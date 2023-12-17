#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

if [[ "${INSTALLTERRAFORM}" == "true" ]]; then
  logger "info" "Installing Terraform (version: ${TERRAFORMVERSION})"
  bash "$(dirname "${0}")"/install-terraform.sh
fi
