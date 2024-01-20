#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "gh version" gh version
check "gh completion existence" stat /usr/local/share/zsh/site-functions/_gh

reportResults
