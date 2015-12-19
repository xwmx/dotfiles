###############################################################################
# GVM
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

# _initialize_gvm()
#
# Usage:
#   _initialize_gvm
#
# Description:
#   Initialize GVM.
_initialize_gvm() {
  if [[ -L "${HOME}/.gvm" ]]
  then
    printf "\$HOME/.gvm already linked.\n"
    return 1
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
  gvm install go1.4
  gvm use go1.4
  gvm install go1.5
  gvm use go1.5 --default
}

# _deinitialize_gvm()
#
# Usage:
#   _deinitialize_gvm
#
# Description:
#   Remove all of the generated, untracked directories.
_deinitialize_gvm() {
  if [[ -L "${HOME}/.gvm" ]]
  then
    bindle unlink .gvm
  fi

  for _directory in "archive" "environments" "gos" "pkgsets" "scripts/gvm"
  do
    _remove "${DOTFILES}/home/.gvm/${_directory}"
  done
}
