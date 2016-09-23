###############################################################################
# macos_path_fix.zsh
#
# See "$HOME/.shared_env.d/_macos_path_fix.zsh" for more information.
##############################################################################

if is_osx && is_el_capitan
then
  setopt global_rcs
fi
