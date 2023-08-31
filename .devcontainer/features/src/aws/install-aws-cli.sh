#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

VERSION="${AWSCLIVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  ARTEFACT="awscli-exe-linux-$(uname -m).zip"
else
  ARTEFACT="awscli-exe-linux-$(uname -m)-${VERSION}.zip"
fi

curl --fail-with-body --location "https://awscli.amazonaws.com/${ARTEFACT}" \
  --output "${ARTEFACT}"

unzip "${ARTEFACT}"

bash ./aws/install

rm --recursive --force aws "${ARTEFACT}"

echo "complete -C '/usr/local/bin/aws_completer' aws" >/home/vscode/.devcontainer/feature-completion/aws.sh
