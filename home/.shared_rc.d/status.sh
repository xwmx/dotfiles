###############################################################################
# status.sh
###############################################################################

# status()
#
# Usage:
#   status [--list] [<path>]
#   status -h | --help
#
# Options:
#   -h --help  Print help information.
#   --list     List directory contetents.
#
# Description:
#   Display the status information about the current directory or <path>.
status() {
  # _status_print_header()
  #
  # Usage:
  #   _status_print_header <string>
  #
  # Description:
  #   Print <string> formatted for a status header.
  _status_print_header() {
    local _label="${1:-}"
    local _label_length
    _label_length="$(_astral_visible_length "{$_label}")"
    local _spacer_length
    _spacer_length="$((COLUMNS - _label_length * 2 - 6))"
    local _spacer
    _spacer="$(_astral_spaces "${_spacer_length}" | sed 's/ /─/g')"

    local _formatted_label
    _formatted_label="$(tput setaf 5)${_label}"
    local _left_label
    _left_label="$(tput bold)$(tput setaf 7)›› ${_formatted_label}"
    local _right_label
    _right_label="$(tput bold) ${_formatted_label} $(tput setaf 7)‹‹"
    printf "%s\\n" "${_left_label} $(tput setaf 232)${_spacer} ${_right_label}$(tput sgr0)"
  }

  local _print_help=0
  local _list_contents=0
  local _current_directory
  _current_directory="$(pwd)"
  local _target_directory="${_current_directory}"

  for __arg in "$@"
  do
    if [ "${__arg}" = "-h" ] || [ "${__arg}" = "--help" ]
    then
      _print_help=1
    elif [ "${__arg}" = "-l" ] || [ "${__arg}" = "--list" ]
    then
      _list_contents=1
    else
      _target_directory="${__arg:-}"
    fi
  done
  if ((_print_help))
  then
    cat <<HEREDOC
Usage:
  status [--list] [<path>]
  status -h | --help

Options:
  -h --help  Print help information.
  --list     List directory contetents.

Description:
  Display the status information about the current directory or <path>.
HEREDOC
    return 0
  else
    if [ "${_current_directory}" != "${_target_directory}" ]
    then
      if [ "${_target_directory}" = "-la" ] &&
         [ ! -d "${_target_directory}" ]
      then
        # Common `ls -la` -> `sl -la` transposition typo. Assume that the
        # intent was to list the current directory.
        status --list
      elif ((_list_contents))
      then
        (cd "${_target_directory}" && status --list)
      else
        (cd "${_target_directory}" && status)
      fi
      return 0
    fi

    # Directory Path
    _status_print_header "Directory"
    printf "\\n"
    pwd
    printf "\\n"

    # git status
    #
    # via: via: https://stackoverflow.com/a/2180367
    if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
    then
      _status_print_header "git log"
      printf "\\n"
      # Use `--no-pager` before `log` to disable pager.
      # https://stackoverflow.com/a/7737071
      git --no-pager log \
        --graph \
        --pretty=format:'%Cred%h%Creset - %Cgreen(%cr)%Creset%C(yellow)%d%Creset %n› %s' \
        --abbrev-commit \
        --date=relative \
        -3
      printf "\\n"
      printf "\\n"

      _status_print_header "git status"
      printf "\\n"
      git status
      printf "\\n"
    fi

    if ((_list_contents))
    then
      # Directory Listing
      _status_print_header "Contents"
      printf "\\n"
      e
      printf "\\n"
    fi
  fi
}

s() {
  status "$@"
}

sl() {
  status --list "$@"
}
