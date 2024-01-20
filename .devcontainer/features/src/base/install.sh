#!/usr/bin/env bash

##################################################
# Prerequisite
##################################################

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/usr/local/bin/devcontainer-utils /usr/local/bin/devcontainer-utils

# shellcheck source=/dev/null
# file not accessible until being built
source /usr/local/bin/devcontainer-utils

##################################################
# Dev Container Configuration
##################################################

install --owner=vscode --group=vscode --mode=644 "$(dirname "${0}")"/src/home/vscode/.zshrc /home/vscode/.zshrc
install --directory --owner=vscode --group=vscode /home/vscode/.devcontainer/featurerc.d
install --owner=vscode --group=vscode --mode=755 "$(dirname "${0}")"/src/home/vscode/.oh-my-zsh/custom/themes/woffenden.zsh-theme /home/vscode/.oh-my-zsh/custom/themes/woffenden.zsh-theme
install --owner=vscode --group=vscode --mode=755 "$(dirname "${0}")"/src/usr/local/etc/vscode-dev-containers/first-run-notice.txt /usr/local/etc/vscode-dev-containers/first-run-notice.txt

##################################################
# APT
##################################################

apt_install "direnv"
apt_install "python3-pip"

##################################################
# Python
##################################################

pip_install "pip"
