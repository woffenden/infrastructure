#!/usr/bin/env bash

##################################################
# Variables
##################################################
export _RUNTIME_DATE=$( date +'%Y-%m-%dT%H:%M:%S.00000Z' )
export CF_ACCOUNT_ID="${CLOUDFLARE_ACCOUNT_ID}"
export CF_BEARER_TOKEN="${CLOUDFLARE_API_TOKEN_TEAMS_ADBLOCK}"

export TEMP_DIRECTORY="temp"
export STEVENBLACK_HOSTS_VERSION="3.9.66" # https://github.com/StevenBlack/hosts/releases
export BLOCKLIST_DATA_REMOTE="https://raw.githubusercontent.com/StevenBlack/hosts/${STEVENBLACK_HOSTS_VERSION}/hosts"
export BLOCKLIST_DATA_LOCAL="${TEMP_DIRECTORY}/hosts"
export SANITISED_BLOCKLIST_DATA="${BLOCKLIST_DATA_LOCAL}-sanitised"

export SPLIT_DIRECTORY="${TEMP_DIRECTORY}/split"
export SPLIT_LINES_NUM="1000"
export SPLIT_SUFFIX_NUM="2"
export SPLIT_PREFIX="hosts-"

export PROCESSED_DIRECTORY="${TEMP_DIRECTORY}/processed"
export PROCESSED_LIST_PREFIX="list-"
export PROCESSED_RULE_PREFIX="rule-"

export CF_LIST_PREFIX="adblock-hosts-"
export CF_RULE_PREFIX="adblock-hosts-"

##################################################
# Script
##################################################
echo "Creating directory [ ${TEMP_DIRECTORY} ]"
rm -rf ${TEMP_DIRECTORY}
mkdir -p ${TEMP_DIRECTORY}

echo "Downloading blacklist data [ ${BLOCKLIST_DATA_REMOTE} ] to [ ${BLOCKLIST_DATA_LOCAL} ]"
rm -rf ${BLOCKLIST_DATA_LOCAL}
curl --silent --location ${BLOCKLIST_DATA_REMOTE} --output ${BLOCKLIST_DATA_LOCAL}

echo "Sanitising blacklist data [ ${BLOCKLIST_DATA_LOCAL} ] to [ ${SANITISED_BLOCKLIST_DATA} ]"
cat ${BLOCKLIST_DATA_LOCAL} \
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
  | awk '{ print $2 }' > ${SANITISED_BLOCKLIST_DATA}


echo "Splitting [ ${SANITISED_BLOCKLIST_DATA} ] into [ ${SPLIT_DIRECTORY} ] with chunks of [ ${SPLIT_LINES_NUM} ] and a prefix [ ${SPLIT_PREFIX} ]"
rm -rf ${SPLIT_DIRECTORY}
mkdir -p ${SPLIT_DIRECTORY}
split --lines=${SPLIT_LINES_NUM} --numeric-suffixes --suffix-length=${SPLIT_SUFFIX_NUM} ${SANITISED_BLOCKLIST_DATA} ${SPLIT_DIRECTORY}/${SPLIT_PREFIX}

echo "Processing split files in [ ${SPLIT_DIRECTORY} ]"
rm -rf ${PROCESSED_DIRECTORY}
mkdir -p ${PROCESSED_DIRECTORY}
for filename in ${SPLIT_DIRECTORY}/*; do
  chunkId=$( echo ${filename} | sed "s|${SPLIT_DIRECTORY}/${SPLIT_PREFIX}||" )
	echo "Processing split file [ ${filename} ] with chunk ID [ ${chunkId} ]"
	
	while read hostname; do
		printf '{"value": "%s","created_at": "%s"},' ${hostname} ${_RUNTIME_DATE} >> ${PROCESSED_DIRECTORY}/${SPLIT_PREFIX}${chunkId}
	done <${filename}
	truncate -s-1 ${PROCESSED_DIRECTORY}/${SPLIT_PREFIX}${chunkId} # Remove last character ','

  echo "Rendering [ ${PROCESSED_DIRECTORY}/${PROCESSED_LIST_PREFIX}${chunkId}.json ] from [ ${PROCESSED_DIRECTORY}/${SPLIT_PREFIX}${chunkId} ]"
	renderedHosts=$( cat ${PROCESSED_DIRECTORY}/${SPLIT_PREFIX}${chunkId} )
cat > ${PROCESSED_DIRECTORY}/${PROCESSED_LIST_PREFIX}${chunkId}.json <<EOF
{
  "name": "${CF_LIST_PREFIX}${chunkId}",
  "description": "Ad Block Hosts - Chunk ID: ${chunkId}",
  "type": "DOMAIN",
  "items": [
    ${renderedHosts}
  ]
}
EOF

#### API Stuff

#### CLEAN RULES
  echo "Looking for Gateway rule named [ ${CF_LIST_PREFIX}${chunkId} ]"
  cfRuleId=$( curl --silent -X GET "https://api.cloudflare.com/client/v4/accounts/${CF_ACCOUNT_ID}/gateway/rules" \
                -H "Authorization: Bearer ${CF_BEARER_TOKEN}" \
                -H "Content-Type: application/json" \
                | jq -r --arg LISTID "${CF_LIST_PREFIX}${chunkId}" '.result[] | select(.name==$LISTID) | .id' 2>/dev/null )
  if [[ -z "${cfRuleId}" ]]; then
    echo "No Gateway rule found matching [ ${CF_LIST_PREFIX}${chunkId} ]"
  else
    echo "Gateway rule found matching [ ${CF_LIST_PREFIX}${chunkId} ]"
    echo "Deleting Gateway rule [ ${CF_LIST_PREFIX}${chunkId} ]"
    deleteCfRule=$( curl --silent -X DELETE "https://api.cloudflare.com/client/v4/accounts/${CF_ACCOUNT_ID}/gateway/rules/${cfRuleId}" \
      -H "Authorization: Bearer ${CF_BEARER_TOKEN}" \
      -H "Content-Type: application/json" | jq -r '.success' )
    if [[ "${deleteCfRule}" == "true" ]]; then
      echo "Successfully deleted Gateway rule [ ${CF_LIST_PREFIX}${chunkId} ]"
    else
      echo "Failed to delete Gateway rule [ ${CF_LIST_PREFIX}${chunkId} ]"
    fi
  fi

#### CLEAN LISTS
  echo "Looking for Gateway list named [ ${CF_LIST_PREFIX}${chunkId} ]"
  cfListId=$( curl --silent -X GET "https://api.cloudflare.com/client/v4/accounts/${CF_ACCOUNT_ID}/gateway/lists" \
                -H "Authorization: Bearer ${CF_BEARER_TOKEN}" \
                -H "Content-Type: application/json" \
                | jq -r --arg LISTID "${CF_LIST_PREFIX}${chunkId}" '.result[] | select(.name==$LISTID) | .id' 2>/dev/null )
  if [[ -z "${cfListId}" ]]; then
    echo "No Gateway list found matching [ ${CF_LIST_PREFIX}${chunkId} ]"
  else
    echo "Gateway list found matching [ ${CF_LIST_PREFIX}${chunkId} ]"
    echo "Deleting Gateway list [ ${CF_LIST_PREFIX}${chunkId} ]"
    deleteCfList=$( curl --silent -X DELETE "https://api.cloudflare.com/client/v4/accounts/${CF_ACCOUNT_ID}/gateway/lists/${cfListId}" \
      -H "Authorization: Bearer ${CF_BEARER_TOKEN}" \
      -H "Content-Type: application/json" | jq -r '.success' )
    if [[ "${deleteCfList}" == "true" ]]; then
      echo "Successfully deleted Gateway list [ ${CF_LIST_PREFIX}${chunkId} ]"
    else
      echo "Failed to delete Gateway list [ ${CF_LIST_PREFIX}${chunkId} ]"
    fi
  fi

#### UPLOAD LIST
  uploadCfList=$( curl --silent -X POST "https://api.cloudflare.com/client/v4/accounts/${CF_ACCOUNT_ID}/gateway/lists" \
                    -H "Authorization: Bearer ${CF_BEARER_TOKEN}" \
                    -H "Content-Type: application/json" \
                    -d @${PROCESSED_DIRECTORY}/${PROCESSED_LIST_PREFIX}${chunkId}.json | jq -r '.success' )

  if [[ "${uploadCfList}" == "true" ]]; then
    cfListId=$( curl --silent -X GET "https://api.cloudflare.com/client/v4/accounts/${CF_ACCOUNT_ID}/gateway/lists" \
                  -H "Authorization: Bearer ${CF_BEARER_TOKEN}" \
                  -H "Content-Type: application/json" \
                  | jq -r --arg LISTID "${CF_LIST_PREFIX}${chunkId}" '.result[] | select(.name==$LISTID) | .id' )
    cfListIdSanitised=$( echo "${cfListId}" | sed 's|-||g' )
    echo "Successfully uploaded Gateway list [ ${CF_LIST_PREFIX}${chunkId} ] with ID [ ${cfListId} ]"
  else
    echo "Failed to upload Gateway list [ ${CF_LIST_PREFIX}${chunkId} ]"
  fi

#### RENDER LIST
echo "Rendering [ ${PROCESSED_DIRECTORY}/${PROCESSED_RULE_PREFIX}${chunkId}.json ] with list [ ${cfListId} ]"
cat > ${PROCESSED_DIRECTORY}/${PROCESSED_RULE_PREFIX}${chunkId}.json <<EOF
{
  "name": "${CF_RULE_PREFIX}${chunkId}",
  "description": "Ad Block Hosts - Chunk ID: ${chunkId}",
  "precedence": 1000${chunkId},
  "enabled": true,
  "action": "block",
  "filters": [
    "dns"
  ],
  "traffic": "any(dns.domains[*] in \$${cfListIdSanitised})",
  "identity": "",
  "device_posture": "",
  "rule_settings": {
    "block_page_enabled": false,
    "block_reason": "",
    "override_ips": null,
    "override_host": "",
    "l4override": null,
    "biso_admin_controls": {
      "dp": false,
      "dcp": false,
      "dd": false,
      "du": false,
      "dk": false
    },
    "add_headers": {},
    "ip_categories": false,
    "check_session": null,
    "insecure_disable_dnssec_validation": false
  }
}
EOF

  echo "Creating Gateway rule [ ${CF_RULE_PREFIX}${chunkId} ] from [ ${PROCESSED_DIRECTORY}/${PROCESSED_RULE_PREFIX}${chunkId}.json ]"
  createCfRule=$( curl --silent -X POST "https://api.cloudflare.com/client/v4/accounts/${CF_ACCOUNT_ID}/gateway/rules" \
                    -H "Authorization: Bearer ${CF_BEARER_TOKEN}" \
                    -H "Content-Type: application/json" \
                    -d @${PROCESSED_DIRECTORY}/${PROCESSED_RULE_PREFIX}${chunkId}.json | jq -r '.success' )
  if [[ "${createCfRule}" == "true" ]]; then
    echo "Successfully created Gateway rule [ ${CF_RULE_PREFIX}${chunkId} ]"
  else
    echo "Failed to created Gateway rule [ ${CF_RULE_PREFIX}${chunkId} ]"
  fi
done
