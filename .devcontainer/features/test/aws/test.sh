#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "aws version" aws --version
check "aws-vault version" aws-vault --version

reportResults