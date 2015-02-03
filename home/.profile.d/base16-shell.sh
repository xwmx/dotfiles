#==============================================================================
# Base16 Shell
#
# A shell script to change your shell's default ANSI colors but most
# importantly, colors 17 to 21 of your shell's 256 colorspace (if supported by
# your terminal). This script makes it possible honor the original bright
# colors of your shell (e.g. bright green is still green and so on) whilst
# providing the additional base16 colors to applications such as Vim.
#
# https://github.com/chriskempson/base16-shell
#==============================================================================

BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s "$BASE16_SHELL" ]] && source "$BASE16_SHELL"
