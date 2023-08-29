#!/usr/bin/env bash

##################################################
# Prerequisite
##################################################

install --owner=vscode --group=vscode --mode=775 "$(dirname "${0}")"/src/usr/local/bin/devcontainer-utils /usr/local/bin/devcontainer-utils

# shellcheck source=/dev/null excluding as file not available until building
source /usr/local/bin/devcontainer-utils

##################################################
# APT
##################################################

apt_install "direnv"
apt_install "python3-pip"

##################################################
# Python
##################################################

pip_install "pip"
