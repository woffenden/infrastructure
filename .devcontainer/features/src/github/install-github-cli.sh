#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

GITHUB_REPOSITORY="cli/cli"
VERSION="${GITHUBCLIVERSION:-"latest"}"

if [[ "${VERSION}" == "latest" ]]; then
  get_github_latest_tag "${GITHUB_REPOSITORY}"
  VERSION="${GITHUB_LATEST_TAG}"
  VERSION_STRIP_V="${GITHUB_LATEST_TAG_STRIP_V}"
else
  VERSION="${VERSION}"
fi

curl --fail-with-body --location "https://github.com/${GITHUB_REPOSITORY}/releases/download/${VERSION}/gh_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.tar.gz" \
  --output "gh_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.tar.gz"

tar --verbose --gzip --extract --file "gh_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.tar.gz"

mv "gh_${VERSION_STRIP_V}_linux_${ARCHITECTURE}/bin/gh" /usr/local/bin/gh

rm --recursive --force "gh_${VERSION_STRIP_V}_linux_${ARCHITECTURE}" "gh_${VERSION_STRIP_V}_linux_${ARCHITECTURE}.tar.gz"

gh completion -s zsh > /usr/local/share/zsh/site-functions/_gh
