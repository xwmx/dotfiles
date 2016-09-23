###############################################################################
# macos_path_fix.zsh
#
# See "$HOME/.shared_env.d/_macos_path_fix.zsh" for more information.
##############################################################################

if is_osx
then
  if is_el_capitan || is_sierra
  then
    setopt global_rcs
  fi
fi
