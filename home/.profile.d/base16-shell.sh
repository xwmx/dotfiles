###############################################################################
# Base16 Shell
#
# A shell script to change your shell's default ANSI colors but most
# importantly, colors 17 to 21 of your shell's 256 colorspace (if supported by
# your terminal). This script makes it possible honor the original bright
# colors of your shell (e.g. bright green is still green and so on) whilst
# providing the additional base16 colors to applications such as Vim.
#
# https://github.com/chriskempson/base16-shell
###############################################################################

# Including favorites here for easier switching.

#_base_16_shell_theme="3024"
#_base_16_shell_theme="bespin"
#_base_16_shell_theme="brewer"
#_base_16_shell_theme="eighties"
#_base_16_shell_theme="google"
#_base_16_shell_theme="grayscale"
#_base_16_shell_theme="greenscreen"
#_base_16_shell_theme="isotope"        # close to original
#_base_16_shell_theme="shapeshifter"   # close to original
#_base_16_shell_theme="summerfruit"
#_base_16_shell_theme="tomorrow"
_base_16_shell_theme="twilight"

BASE16_SHELL="$HOME/.config/base16-shell/base16-$_base_16_shell_theme.dark.sh"
[[ -s "$BASE16_SHELL" ]] && source "$BASE16_SHELL"
