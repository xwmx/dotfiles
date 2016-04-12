###############################################################################
# vim
#
# vim environment settings
#
# http://www.vim.org/
# https://code.google.com/p/macvim/
# http://neovim.org/
###############################################################################

# If MacVim is installed, then set VIMRUNTIME to MacVim's runtime path. The
# primary reason for this in the current configuration is to make Neovim
# (nvim) perform much better on OS X.
#
# https://github.com/neovim/neovim/issues/193
# http://vim.wikia.com/wiki/Set_VIMRUNTIME_within_vimrc
_macvim_app_path="${HOME}/Applications/MacVim.app"
if command_exists "mvim" && [[ -e "${_macvim_app_path}" ]]
then
  # NOTE: Disabled. This triggers an error for unknown reasons.
  # TODO: Investigate error and fix or remove this file.
  # export VIMRUNTIME="${_macvim_app_path}/Contents/Resources/vim/runtime"
fi
