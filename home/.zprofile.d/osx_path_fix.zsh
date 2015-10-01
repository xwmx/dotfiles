###############################################################################
# osx_path_fix.zsh
#
# See "$HOME/.zshenv.d/osx_path_fix.zsh" for more information.
##############################################################################

if is_osx && is_el_capitan
then
  setopt global_rcs
fi
