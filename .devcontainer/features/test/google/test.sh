#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "gcloud version" gcloud --version
check "gcloud featurerc existence" stat /home/vscode/.devcontainer/featurerc.d/gcloud.sh

reportResults
