#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

if [[ "${INSTALLAWSCLI}" == "true" ]]; then
  logger "info" "Installing AWS CLI (version: ${AWSCLIVERSION})"
  bash "$(dirname "${0}")"/install-aws-cli.sh
fi

if [[ "${INSTALLAWSVAULT}" == "true" ]]; then
  logger "info" "Installing AWS Vault (version: ${AWSVAULTVERSION})"
  bash "$(dirname "${0}")"/install-aws-vault.sh
fi
