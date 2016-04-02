###############################################################################
# .shared_rc.d/emacs.sh
#
# Emax - A Wrapper for Emacs
#
# GNU Emacs text editor
#
# https://www.gnu.org/software/emacs/
###############################################################################

# emax
#
# Control the emacs daemon and client.
emax() {
  if [[ "${1}" =~ '^-h|--help$' ]]
  then
    cat <<HEREDOC
Usage:
  ${0}
  ${0} gui
  ${0} (start | status | stop | restart)
  ${0} -h | --help

Subcommands:
  (none)   Launch \`emacsclient\`, silently launching and connecting to
           \`emacs --daemon\` if it's not already running.
  gui      Open GUI Emacs.
  start    Start the Emacs daemon.
  status   Print the Emacs daemon status.
  stop     Stop the Emacs daemon.
  restart  Restart the Emacs daemon.

Options:
  -h --help  Display this usage information.

Description:
  A wrapper for Emacs with shortcuts for the daemon and client.

\`emacsclient --help\`
--------------------
HEREDOC
    emacsclient --help
  elif [[ "${1}" =~ '^start|up$' ]]
  then
    if ! "${0}" status &>/dev/null
    then
      emacs --daemon &>/dev/null \
        && printf "\`emacs --daemon\` started.\n"
    else
      printf "\`emacs --daemon\` is already running.\n"
      return 1
    fi
  elif [[ "${1}" =~ '^stop|down$' ]]
  then
    if "${0}" status &>/dev/null
    then
      # Source, with other approaches:
      # http://stackoverflow.com/q/1167484
      emacsclient -e "(kill-emacs)" \
        && printf "\`emacs --daemon\` stopped.\n"
    else
      printf "\`emacs --daemon\` is not running.\n"
      return 1
    fi
  elif [[ "${1}" == "restart" ]]
  then
    "${0}" status &>/dev/null && "${0}" stop
    "${0}" start
  elif [[ "${1}" =~ ^stat ]]
  then
    if [[ "$(pgrep -lf emacs)" =~ 'emacs --daemon' ]]
    then
      printf "\`emacs --daemon\` is running.\n"
      return 0
    else
      printf "\`emacs --daemon\` is not running.\n"
      return 1
    fi
  elif [[ "${1}" == "gui" ]]
  then
    # More information: http://stackoverflow.com/q/10171280
    #
    # NOTE: Not working on systems with homebrew-install Emacs.app and
    # aliasapp.rb.
    # NOTE: First element in `$_app_bundle_paths` is blank for unknown reasons.
    local _app_bundle_paths
    _app_bundle_paths=($(
      mdfind kMDItemContentTypeTree=com.apple.application-bundle -onlyin / \
        | grep 'Emacs.app'
    ))
    (open -a "${_app_bundle_paths[1]:-}" "${@:2}") &
  else
    if "${0}" status &>/dev/null
    then
      emacsclient -t "$@"
    else
      "${0}" start && emacsclient -t "$@"
    fi
  fi
}

alias emc='emax'
alias emd='emax status'
