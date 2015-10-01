###############################################################################
# __.sh
###############################################################################

###############################################################################
# Verbose Init
#
# Print the current file path when starting up with verbose output. This file's
# presence makes it possible to confirm that files in this directory are
# sourced.
###############################################################################

. "$HOME/.shared_verbose_init"
__verbose_init printf "Loading %s\n" \
  "$([[ -n $BASH_VERSION ]] && echo "$BASH_SOURCE" || echo "$0")"
