#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

if [[ "${INSTALLAWSCLI}" == "true" ]]; then
  logger "info" "Installing AWS CLI (version: ${AWSCLIVERSION})"
  bash "$(dirname "${0}")"/install-aws-cli.sh
fi

if [[ "${INSTALLAWSSSOCLI}" == "true" ]]; then
  logger "info" "Installing AWS SSO CLI (version: ${AWSSSOCLIVERSION})"
  bash "$(dirname "${0}")"/install-aws-sso-cli.sh
fi
