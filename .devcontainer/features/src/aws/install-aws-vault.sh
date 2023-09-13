#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="99designs/aws-vault"
VERSION="${AWSVAULTVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  # shellcheck disable=SC2034
  VERSION_STRIP_V="${VERSION#v}"
fi

curl --fail-with-body --location "https://github.com/${GITHUB_REPOSITORY}/releases/download/${VERSION}/aws-vault-linux-${ARCHITECTURE}" \
  --output "aws-vault"

install --owner=vscode --group=vscode --mode=775 aws-vault /usr/local/bin/aws-vault
install --directory --owner=vscode --group=vscode /home/vscode/.awsvault
install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/home/vscode/.devcontainer/feature-completion/aws-vault.sh /home/vscode/.devcontainer/feature-completion/aws-vault.sh
