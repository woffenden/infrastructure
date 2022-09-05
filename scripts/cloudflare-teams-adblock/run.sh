#!/usr/bin/env bash

#####
export _RUNTIME_DATE=$( date +'%Y-%m-%dT%H:%M:%S.00000Z' )
export _RUNTIME_TEMP="$( pwd )/tmp"
export _RUNTIME_SPLIT_PREFIX="hosts-"
export _RUNTIME_RULES_PREFIX="rule-"

export ADBLOCK_SOURCE_VERSION=$( curl --silent https://api.github.com/repos/StevenBlack/hosts/releases/latest | jq -r '.tag_name' )
export ADBLOCK_SOURCE_DL_URL="https://raw.githubusercontent.com/StevenBlack/hosts/${ADBLOCK_SOURCE_VERSION}/hosts"

export ADBLOCK_CF_GATEWAY_RULE_PREFIX="managed-adblock-rule-"
export ADBLOCK_CF_GATEWAY_LIST_PREFIX="managed-adblock-list-"

export CF_API_BASE_URL="https://api.cloudflare.com/client/v4"
export CF_API_CURL_XGET=(--silent \
                         --request GET \
                         --header "Authorization: Bearer ${CF_BEARER_TOKEN}" \
                         --header "Content-Type: application/json" \
                         ${CF_API_BASE_URL}
                        )
export CF_API_CURL_XDEL=(--silent \
                         --request DELETE \
                         --header "Authorization: Bearer ${CF_BEARER_TOKEN}" \
                         --header "Content-Type: application/json" \
                         ${CF_API_BASE_URL}
                        )
export CF_API_CURL_XPOST=(--silent \
                         --request POST \
                         --header "Authorization: Bearer ${CF_BEARER_TOKEN}" \
                         --header "Content-Type: application/json" \
                         ${CF_API_BASE_URL}
                        )

##### Functions
function init() {
  echo " ----- ⛅ Cloudflare Teams AdBlock ⛅ -----"
}

function detect_system() {
  if [[ "${GITHUB_ACTIONS}" == "true" ]]; then
    echo "🐙 Running on GitHub Actions"
  else
    echo "💻 Running locally"
  fi
}

function cloudflare_token_verify() {
  local getCloudflareTokenVerification=$( curl "${CF_API_CURL_XGET[@]}"/user/tokens/verify | jq -r '.success' )
  if [[ "${getCloudflareTokenVerification}" == "true" ]]; then
    echo "✨ Cloudflare API Token is valid ✨"
  else
    echo "❗️ There is an issue with the Cloudflare API Token ❗️"
    exit 1
  fi
}

function cloudflare_gateway_cleanup() {
  local type=${1}
  local prefix=${2}

  echo "🗑️  Cleaning up Cloudflare Gateway ${type}"

  local getCloudflareGatewayItems=$( curl "${CF_API_CURL_XGET[@]}"/accounts/${CF_ACCOUNT_ID}/gateway/${type} | jq -r '.result[] | .name' 2>/dev/null | grep "${prefix}" | sort  )
  
  if [[ -z "${getCloudflareGatewayItems}" ]]; then
    echo "  🔎 No items found"
  else
    local countCloudflareGatewayItems=$( echo ${getCloudflareGatewayItems} | awk '{ print NF }' )
    echo "  🔎 Found ${countCloudflareGatewayItems} to cleanup"
  fi

  for item in ${getCloudflareGatewayItems}; do
    echo "    ⚙️  Processing ${item}"
    local getCloudflareGatewayItemId=$( curl "${CF_API_CURL_XGET[@]}"/accounts/${CF_ACCOUNT_ID}/gateway/${type}  | jq -r --arg ITEM "${item}" '.result[] | select(.name==$ITEM) | .id' )
    local deleteCloudflareGatewayItem=$( curl "${CF_API_CURL_XDEL[@]}"/accounts/${CF_ACCOUNT_ID}/gateway/${type}/${getCloudflareGatewayItemId} | jq -r '.success' )
    if [[ "${deleteCloudflareGatewayItem}" == "true" ]]; then
      echo "      🎉 Successfully deleted ${item}"
    else
      echo "      😟 Failed to delete ${item}"
      return 1
    fi
  done
}

function generate_adblock_data() {
  echo "🧪 Generating AdBlock data"
  mkdir --parents ${_RUNTIME_TEMP}
  
  echo "  📥 Downloading AdBlock source (${ADBLOCK_SOURCE_VERSION})"
  curl \
    --silent \
    --location \
    --output ${_RUNTIME_TEMP}/hosts \
    ${ADBLOCK_SOURCE_DL_URL}
  
  echo "  🛁 Sanitising AdBlock data"
  cat ${_RUNTIME_TEMP}/hosts \
    | sed '/^#/ d' \
    | grep -v '127.0.0.1' \
    | grep -v '255.255.255.255' \
    | grep -v '::1' \
    | grep -v 'fe80' \
    | grep -v 'ff00' \
    | grep -v 'ff02' \
    | grep -v '0.0.0.0 0.0.0.0' \
    | grep -v '\.a2z.com$' \
    | grep -v '\.apple$' \
    | grep -v '\.apple.com$' \
    | grep -v '\.aaplimg.com$' \
    | grep -v '\.apple-dns.net$' \
    | grep -v '\.appleglobal.102.112.2o7.net$' \
    | grep -v '\.apple.news$' \
    | grep -v '\.cdn-apple.com$' \
    | grep -v '\.mzstatic.com$' \
    | grep -v '\.apple-cloudkit.com$' \
    | grep -v '\.icloud.com$' \
    | grep -v '\.icloud-content.com$' \
    | grep -v '\.me.com$' \
    | awk 'NF' \
    | awk '{ print $2 }' > ${_RUNTIME_TEMP}/hosts-sanitised

  echo "  🪓 Splitting sanitised data"
  mkdir --parents ${_RUNTIME_TEMP}/split
  split --lines=1000 --numeric-suffixes --suffix-length=2 ${_RUNTIME_TEMP}/hosts-sanitised ${_RUNTIME_TEMP}/split/hosts- 2>/dev/null

  rm --recursive --force ${_RUNTIME_TEMP}/processed
  mkdir --parents ${_RUNTIME_TEMP}/processed

  for splitfile in ${_RUNTIME_TEMP}/split/*; do
    local splitId=$( echo ${splitfile} | sed "s|${_RUNTIME_TEMP}/split/${_RUNTIME_SPLIT_PREFIX}||" )
    echo "    ⚙️  Processing split file "${splitfile##*/}""
    while read hostname; do
      printf '{"value": "%s","created_at": "%s"},' ${hostname} ${_RUNTIME_DATE} >> ${_RUNTIME_TEMP}/processed/${_RUNTIME_SPLIT_PREFIX}${splitId}
    done <${splitfile}
    truncate -s-1 ${_RUNTIME_TEMP}/processed/${_RUNTIME_SPLIT_PREFIX}${splitId} # Remove last character ','

    echo "      🧬 Rendering list-${splitId}.json"
    local renderedHosts=$( cat ${_RUNTIME_TEMP}/processed/${_RUNTIME_SPLIT_PREFIX}${splitId} )
    printf '{"name": "%s",\n"description": "%s",\n"type": "DOMAIN",\n"items": [%s]}' \
      "${ADBLOCK_CF_GATEWAY_LIST_PREFIX}${splitId}" \
      "${ADBLOCK_CF_GATEWAY_LIST_PREFIX}${splitId}" \
      "${renderedHosts}" > ${_RUNTIME_TEMP}/processed/list-${splitId}.json

    echo "      📜 Creating list ${ADBLOCK_CF_GATEWAY_LIST_PREFIX}${splitId}"
    local postCloudflareGatewayList=$( curl "${CF_API_CURL_XPOST[@]}"/accounts/${CF_ACCOUNT_ID}/gateway/lists --data @${_RUNTIME_TEMP}/processed/list-${splitId}.json | jq -r '.success' )
    if [[ "${postCloudflareGatewayList}" == "true" ]]; then
      local getCloudflareGatewayListId=$( curl "${CF_API_CURL_XGET[@]}"/accounts/${CF_ACCOUNT_ID}/gateway/lists | jq -r --arg LISTID "${ADBLOCK_CF_GATEWAY_LIST_PREFIX}${splitId}" '.result[] | select(.name==$LISTID) | .id' )
      local sanitiseCloudflareGatewayListId=$( echo "${getCloudflareGatewayListId}" | sed 's|-||g' )
      echo "        🎉 Successfully created list ${ADBLOCK_CF_GATEWAY_LIST_PREFIX}${splitId}"
    else
      echo "        😟 Failed to create list ${ADBLOCK_CF_GATEWAY_LIST_PREFIX}${splitId}"
      return 1
    fi

    echo "      🛂 Creating rule ${ADBLOCK_CF_GATEWAY_RULE_PREFIX}${splitId}"
    echo "        🧬 Rendering rule-${splitId}.json"
    printf '{"name": "%s","description": "Rule %s","precedence": 1000%s,"enabled": true,"action": "block","filters": ["dns"],"traffic": "any(dns.domains[*] in $%s)","identity": "","device_posture": "","rule_settings": {"block_page_enabled": false,"block_reason": "","override_ips": null,"override_host": "","l4override": null,"biso_admin_controls": {"dp": false,"dcp": false,"dd": false,"du": false,"dk": false},"add_headers": {},"ip_categories": false,"check_session": null,"insecure_disable_dnssec_validation": false}}' \
      "${ADBLOCK_CF_GATEWAY_RULE_PREFIX}${splitId}" \
      "${splitId}" \
      "${splitId}" \
      "${sanitiseCloudflareGatewayListId}" > ${_RUNTIME_TEMP}/processed/rule-${splitId}.json

    local postCloudflareGatewayRule=$( curl "${CF_API_CURL_XPOST[@]}"/accounts/${CF_ACCOUNT_ID}/gateway/rules --data @${_RUNTIME_TEMP}/processed/rule-${splitId}.json | jq -r '.success' )
    if [[ "${postCloudflareGatewayList}" == "true" ]]; then
      echo "        🎉 Successfully created rule ${ADBLOCK_CF_GATEWAY_RULE_PREFIX}${splitId}"
    else
      echo "        😟 Failed to create rule ${ADBLOCK_CF_GATEWAY_RULE_PREFIX}${splitId}"
      return 1
    fi
  done
}


##### Script
init
detect_system
cloudflare_token_verify
cloudflare_gateway_cleanup "rules" "${ADBLOCK_CF_GATEWAY_RULE_PREFIX}"
cloudflare_gateway_cleanup "lists" "${ADBLOCK_CF_GATEWAY_LIST_PREFIX}"
generate_adblock_data
