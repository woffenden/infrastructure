#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

get_system_architecture

# Ignoring because we'll use this at a later date
# shellcheck disable=SC2034
VERSION="${GCLOUDCLIVERSION:-"latest"}"

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor --output /usr/share/keyrings/cloud.google.gpg

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee --append /etc/apt/sources.list.d/google-cloud-sdk.list

apt_install "google-cloud-cli"
