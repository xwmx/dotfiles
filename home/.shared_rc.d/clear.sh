###############################################################################
# .shared_rc.d/clear.sh
#
# A wrapper for `clear` that includes clearing the scroll-back buffer.
###############################################################################

_CLEAR_COMMAND="$(which clear)"
clear() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]
  then
    cat <<HEREDOC
Usage:
  clear
  clear --all
  clear -h | --help

Options:
  --all      Clear Scrollback.
  -h --help  Display this usage information.

Description:
  A wrapper for \`clear\` that includes clearing the scroll-back buffer.
HEREDOC
  elif [ "$1" = "--all" ]
  then
    # Option 1:
    #   printf '\e]50;ClearScrollback\a'
    # Option 2:
    #   "$_CLEAR_COMMAND"
    #   printf '\033[3J'
    # Option 3:
    printf '\033c\033[3J'
  else
    "$_CLEAR_COMMAND"
  fi
}
