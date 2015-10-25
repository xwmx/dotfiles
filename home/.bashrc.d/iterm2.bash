###############################################################################
# iTerm2 Shell Integration
#
# iTerm2 may be integrated with the unix shell so that it can keep track of
# your command history, current working directory, host name, and more--even
# over ssh. This enables several useful features.
#
# Usage:
#   https://iterm2.com/shell_integration.html
#
# https://www.iterm2.com/
# https://github.com/gnachman/iTerm2
###############################################################################

# bash integration startup file
#
# Received via command:
#   curl -L https://iterm2.com/misc/bash_startup.in >> \
#     ~/.iterm2_shell_integration.bash
#
# NOTE: when `$TERM` is set to "dumb" and possibly when it's blank, this
# script prints unexpected output. Avoid this by skipping the sourcing of this
# shell integration script unless `$TERM` is set to something else.
if [[ -n "$TERM" ]] && [[ "$TERM" != "dumb" ]]
then
  source "$HOME/.iterm2_shell_integration.bash"
fi
