#!/usr/bin/env bash
###############################################################################
# provision.bash
#
# Initialize dotfiles.
#
# To use with Vagrant, add the following to a Vagrantfile:
#
# config.vm.provision "shell",
#   path: "https://raw.githubusercontent.com/alphabetum/dotfiles/master/provision.bash",
#   privileged: false
###############################################################################

# Only clone if ~/.bindle doesn't exist.
#
# This makes it possible to run this script multiple times without existing
# due to a failed clone.
if [[ ! -e "${HOME}/.bindle" ]]
then
  git clone https://github.com/alphabetum/dotfiles.git "$HOME/.bindle"
fi

"$HOME/.bindle/script/bootstrap/linux"
