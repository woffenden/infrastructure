#!/bin/sh

echo "Writing AWS_SSO_SYNC_GOOGLE_CREDENTIALS to credentials.json"
echo "${AWS_SSO_SYNC_GOOGLE_CREDENTIALS}" >/tmp/credentials.json

echo "Running ssosync"
/usr/local/bin/ssosync \
  --log-level "${AWS_SSO_SYNC_LOG_LEVEL}" \
  --region "${AWS_IDENTITY_STORE_REGION}" \
  --identity-store-id "${AWS_IDENTITY_STORE_ID}" \
  --access-token "${AWS_SSO_SYNC_SCIM_TOKEN}" \
  --endpoint "${AWS_SSO_SYNC_SCIM_ENDPOINT}" \
  --google-admin "${AWS_SSO_SYNC_GOOGLE_ADMIN}" \
  --google-credentials /tmp/credentials.json \
  --sync-method "${AWS_SSO_SYNC_METHOD}"
