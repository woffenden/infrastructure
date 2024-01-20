#!/usr/bin/env bash

set -e

# shellcheck source=/dev/null
# file only accessible when using devcontainer CLI
source dev-container-features-test-lib

check "devcontainer-utils file existence" stat /usr/local/bin/devcontainer-utils
check "zshrc file existence" stat /home/vscode/.zshrc
check "featurerc.d directory existence" stat /home/vscode/.devcontainer/featurerc.d
check "theme file existence" stat /home/vscode/.oh-my-zsh/custom/themes/woffenden.zsh-theme
check "first run notice file existence" stat /usr/local/etc/vscode-dev-containers/first-run-notice.txt

check "direnv version" direnv --version
check "pip3 version" pip3 --version

reportResults
