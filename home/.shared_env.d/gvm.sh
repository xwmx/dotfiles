#!/usr/bin/env bash
###############################################################################
# gvm.sh
#
# Go Version Manager
#
# https://github.com/moovweb/gvm
#
# Go
#
# Go is an open source programming language that makes it easy to build simple,
# reliable, and efficient software.
#
# https://golang.org/
#
# GVM resources:
#   http://www.ascent.io/blog/2014/03/11/gvm-with-golang/
#   https://news.ycombinator.com/item?id=6841551
#
# Creatng Workspaces (via the comment linked above):
#   - active workspace
#     `gvm pkgset use some-workspace`
#   - link current directory to some-workspace/src/github.com/you/foo
#     `gvm linkthis github.com/you/foo`
###############################################################################

if [[ -s "${HOME}/.gvm/scripts/gvm" ]]
then
  source "${HOME}/.gvm/scripts/gvm"
fi

###############################################################################
# Initialize and deinitialize gvm
#
# GVM installation is particularly opinionated and requires running the
# installtion script to generate directories and the `gvm` executable. These
# functions  merge the generated directories and files with the home/.gvm
# submodule.
###############################################################################

# _remove()
#
# Usage:
#   _remove /path/to/a/file/or/directory/
#
# Description:
#   If a `trash` command is present in the environment, use that to remove the
#   provided path, otherwise, use rm -rf
_remove() {
  if [[ -z "${1:-}" ]] || [[ ! -e "${1:-}" ]]
  then
    printf "Usage: _remove <path>\n"
    return 1
  fi

  if [[ -f "$(which trash)" ]]
  then
    trash "$1"
  else
    rm -rf "$1"
  fi
}

# gvm_init()
#
# Usage:
#   gvm_init
#
# Description:
#   Initialize GVM.
gvm_init() {
  # Exit if $HOME/.gvm is present and not a symbolic link.
  if [[ -e "${HOME}/.gvm" ]] && [[ ! -L "${HOME}/.gvm" ]]
  then
    printf "\$HOME/.gvm already exists and is not a symbolic link.\n"
    return 1
  fi

  # Unlink if .gvm is a symbolic link.
  if [[ -L "${HOME}/.gvm" ]]
  then
    bindle unlink .gvm
  fi

  # Run the install script.
  zsh < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

  # Copy the generated directories and file over.
  for _directory in "archive" "environments" "gos" "scripts/gvm"
  do
    mv "${HOME}/.gvm/${_directory}" "${DOTFILES}/home/.gvm/${_directory}"
  done

  _remove "${HOME}/.gvm"

  # Reset .zshrc to remove the generated line.
  cd "${DOTFILES}" || return 1
  git checkout -- "${DOTFILES}/home/.zshrc"

  if [[ ! -e "${HOME}/.gvm" ]]
  then
    bindle link .gvm
  fi

  source "${DOTFILES}/home/.gvm/scripts/gvm"

  # Install go1.4 so it's possible to build go1.5, then build go1.5 and set as
  # default.
  gvm install go1.4.3
  gvm use go1.4.3
  gvm install go1.5
  gvm install go1.6
  gvm use go1.6 --default
}

# gvm_deinit()
#
# Usage:
#   gvm_deinit
#
# Description:
#   Remove all of the generated, untracked directories.
gvm_deinit() {
  if [[ -L "${HOME}/.gvm" ]]
  then
    bindle unlink .gvm
  fi

  for _directory in "archive" "environments" "gos" "pkgsets" "scripts/gvm"
  do
    _remove "${DOTFILES}/home/.gvm/${_directory}"
  done
}
