#!/bin/bash
sudo subscription-manager register --username=$RH_USER --password=$RH_USER_PASSWORD --force
sudo subscription-manager attach
sudo subscription-manager config --rhsm.manage_repos=1

sudo dnf -y install osbuild-composer composer-cli cockpit-composer

# enable image builder
sudo systemctl enable --now osbuild-composer.socket

# enable image builder in cockpit
sudo systemctl enable --now cockpit.socket

# Load the shell configuration script so that the autocomplete feature for the composer-cli command starts 
# working immediately without logging out and in:
source /etc/bash_completion.d/composer-cli

sudo systemctl restart osbuild-composer

curl -o actions-runner-linux-x64-2.316.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.316.1/actions-runner-linux-x64-2.316.1.tar.gz

# Extract installer
tar xzf ./actions-runner-linux-x64-2.316.1.tar.gz
