#!/usr/bin/env bash

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

if [[ "${INSTALLGITHUBCLI}" == "true" ]]; then
  logger "info" "Installing GitHub CLI (version: ${GITHUBCLIVERSION})"
  bash "$(dirname "${0}")"/install-github-cli.sh
fi
