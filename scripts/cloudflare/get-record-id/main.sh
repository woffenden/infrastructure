#!/usr/bin/env bash

cloudflareEmail="${CLOUDFLARE_EMAIL:-$(gcloud secrets versions access 1 --secret cloudflare-email)}"
export cloudflareEmail

cloudflareApiKey="${CLOUDFLARE_API_KEY:-$(gcloud secrets versions access 1 --secret cloudflare-api-key)}"
export cloudflareApiKey

cloudflareAccountId="${CLOUDFLARE_ACCOUNT_ID:-$(gcloud secrets versions access 1 --secret cloudflare-account-id)}"
export cloudflareAccountId

cloudflareZoneName="${1}"
export cloudflareZoneName

cloudflareRecordName="${2}"
export cloudflareRecordName

echo "Requested Zone: ${cloudflareZoneName}"
echo "Requested Record: ${cloudflareRecordName}"

# Get Zone
cloudflareZoneId=$(curl \
  --silent \
  --request "GET" \
  --url "https://api.cloudflare.com/client/v4/zones" \
  --header "X-Auth-Email: ${cloudflareEmail}" \
  --header "X-Auth-Key: ${cloudflareApiKey}" \
  --header "Content-Type: application/json" | jq -r --arg cloudflareZoneName "${cloudflareZoneName}" '.result[] | select(.name == $cloudflareZoneName) | .id')

# Get Records
cloudflareRecordId=$(curl \
  --silent \
  --request "GET" \
  --url "https://api.cloudflare.com/client/v4/zones/${cloudflareZoneId}/dns_records" \
  --header "X-Auth-Email: ${cloudflareEmail}" \
  --header "X-Auth-Key: ${cloudflareApiKey}" \
  --header "Content-Type: application/json" | jq -r --arg cloudflareRecordName "${cloudflareRecordName}.${cloudflareZoneName}" '.result[] | select(.name == $cloudflareRecordName) | .id')

echo "Result: ${cloudflareRecordId}"
echo "Terraform Reference: ${cloudflareZoneId}/${cloudflareRecordId}"
