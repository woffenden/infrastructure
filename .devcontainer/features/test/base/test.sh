#!/usr/bin/env bash

set -e

source dev-container-features-test-lib

check "devcontainer-utils file existence" stat /usr/local/bin/devcontainer-utils

check "direnv version" direnv --version
check "pip3 version" pip3 --version

reportResults
