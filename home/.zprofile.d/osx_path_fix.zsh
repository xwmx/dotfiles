###############################################################################
# osx_path_fix.zsh
#
# See "$HOME/.zshenv.d/osx_path_fix.zsh" for more information.
##############################################################################

_is_el_capitan() {
  local version
  version="$(sw_vers -productVersion | awk -F. '{print $2}')"
  [ "$version" -eq "11" ]
}

if is_osx && _is_el_capitan
then
  setopt global_rcs
fi
