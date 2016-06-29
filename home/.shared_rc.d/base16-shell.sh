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

set_shell_theme() {
  BASE16_SHELL="${HOME}/.config/base16-shell/scripts/base16-${1}".sh
  [[ -s "${BASE16_SHELL}" ]] && source "${BASE16_SHELL}"
}

# Including favorites here for easier switching.

#set_shell_theme "3024"
#set_shell_theme "bespin"
#set_shell_theme "brewer"
#set_shell_theme "eighties"
#set_shell_theme "google"
#set_shell_theme "grayscale"
#set_shell_theme "greenscreen"
#set_shell_theme "isotope"        # close to original
#set_shell_theme "shapeshifter"   # close to original
#set_shell_theme "summerfruit"
#set_shell_theme "tomorrow"
#set_shell_theme "twilight"

# Set the theme.
#
# Exceptions:
# - There are cases where `$TERM` is not set, which can cause the theme's
#   commands to be printed out in a string. When `$TERM` is unset, the theme
#   is likely unneeded, so we can avoid setting it and triggering these
#   messages.
# - Terminal.app doesn't support setting colors in the 256 colorspace, so
#   these themes do not work with it.
# - There are cases where `$TERM` is set to "dumb", which should be handled
#   here similarly to a blank `$TERM`.
if [[ "${TERM_PROGRAM}" != "Apple_Terminal" ]] &&
   [[ -n "${TERM:-}" ]] &&
   [[ "${TERM}" != "dumb" ]]
then
  set_shell_theme "twilight"
fi
