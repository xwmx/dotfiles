#!/usr/bin/env bash

# Bash 'Strict Mode'
# https://github.com/alphabetum/bash-boilerplate#bash-strict-mode
set -o nounset
set -o errexit
set -o pipefail
IFS="$(printf '\n\t')"

###############################################################################
# Update Config File
###############################################################################

# The cabal configuration file is included as a template since the $HOME
# path has to be absolute path and, therefore, ends up containing
# user-specific information.
#
# This function takes the template file and replaces any instances of the
# string {{$HOME}} with the value of the $HOME environment variable.
_update_cabal_config_from_template() {
  local cabal_dir="$HOME/.cabal"

  # if the template file exists
  if [[ -f "$cabal_dir"/config.template ]]
  then
    # Remove current if present
    if [[ -f "$cabal_dir"/config ]]
    then
      rm "$cabal_dir"/config
    fi
    # copy the template to the original file's location
    cp "$cabal_dir"/config.template "$cabal_dir"/config
    # Replace {{$HOME}} with value of $HOME
    sed -i "s|{{\$HOME}}|$HOME|g" "$cabal_dir"/config
  fi
}

_update_cabal_config_from_template
