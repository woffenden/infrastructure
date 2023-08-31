#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

if [[ "${INSTALLTERRAFORMCLI}" == "true" ]]; then
  logger "info" "Installing TERRAFORM CLI (version: ${TERRAFORMCLIVERSION})"
  bash "$(dirname "${0}")"/install-terraform-cli.sh
fi
