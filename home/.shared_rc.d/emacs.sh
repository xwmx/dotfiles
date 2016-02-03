###############################################################################
# .shared_rc.d/emacs.sh
#
# Emacs
#
# GNU Emacs text editor
#
# https://www.gnu.org/software/emacs/
###############################################################################

# emacsd
#
# Control the emacs daemon.
emacsd() {
  if [[ "${1}" =~ '^-h|--help$' ]]
  then
    cat <<HEREDOC
Usage:
  emacsd (start | status | stop | restart)
  emacsd -h | --help

Options:
  -h --help  Display this usage information.

Description:
  Control the emacs daemon.
HEREDOC
  elif [[ "${1}" =~ '^start|up$' ]]
  then
    if ! emacsd status &>/dev/null
    then
      emacs --daemon &>/dev/null \
        && printf "\`emacs --daemon\` started.\n"
    else
      printf "\`emacs --daemon\` is already running.\n"
      return 1
    fi
  elif [[ "${1}" =~ '^stop|down$' ]]
  then
    if emacsd status &>/dev/null
    then
      # Source, with other approaches:
      # http://stackoverflow.com/q/1167484
      emacsclient -e "(kill-emacs)" \
        && printf "\`emacs --daemon\` stopped.\n"
    else
      printf "\`emacs --daemon\` is not running.\n"
      return 1
    fi
  elif [[ "${1}" =~ ^r ]]
  then
    emacsd status &>/dev/null && emacsd stop
    emacsd start
  else
    if [[ "$(pgrep -lf emacs)" =~ 'emacs --daemon' ]]
    then
      printf "\`emacs --daemon\` is running.\n"
      return 0
    else
      printf "\`emacs --daemon\` is not running.\n"
      return 1
    fi
  fi
}

# emacsc
#
# Wrapper for `emacsclient` with tweaked functionality.
emacsc() {
  if [[ "${1}" =~ '^-h|--help$' ]]
  then
    cat <<HEREDOC
Usage:
  emacsc
  emacsc -h | --help

Options:
  -h --help  Display this usage information.

Description:
  Launch \`emacsclient\`, silently launching and connecting to
  \`emacs --daemon\` if it's not already running.

\`emacsclient --help\`
--------------------
HEREDOC
    emacsclient --help
  else
    if emacsd status &>/dev/null
    then
      emacsclient -t "$@"
    else
      emacsd start && emacsclient -t "$@"
    fi
  fi
}

alias emc='emacsc'
alias emd='emacsd'
