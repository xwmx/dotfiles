###############################################################################
# email.sh
###############################################################################

# mutt()
#
# Replace the `mutt` command in the shell to avoid accidentally launching mutt
# without the necessary environment variables that are set using the `email`
# command. Assign the mutt executable path to `$_MUTT_COMMAND` so it's
# available to use in `email`.
MUTT_COMMAND="$(which mutt)"
mutt() {
  printf "Use the \`email\` command to launch mutt.\n\n"
  email --help
}

email() {
  local _mutt_accounts_path="${HOME}/.mutt/accounts"

  _print_email_help() {
    cat <<HEREDOC
Usage:
  email list
  email <address>
  email -h | --help

Options:
  -h --help  Show this help.

Description:
  Simple interface for multi-account mutt.
HEREDOC
  }

  _print_email_list() {
    for _file in "${_mutt_accounts_path}"/*
    do
      local _email_account=''
      _email_account="$(basename ${_file} .sh)"
      if [[ "${_email_account}" != "example@example.com" ]]
      then
        printf "%s\n" "${_email_account}"
      fi
    done
  }

  local -a _email_arguments

  for arg in "${@:-}"
  do
    case $arg in
      -h|--help)
        _print_email_help
        return 0
        ;;
      list)
        _print_email_list
        return 0
        ;;
      *)
        _email_arguments+=("$arg")
        ;;
    esac
  done

  if [[ -z "${_email_arguments[@]:-}" ]]
  then # there are no arguments.
    _print_email_help
    return 1
  fi

  if [[ "${_email_arguments[1]}" =~ ^.+@.+$ ]]
  then
    local _email_address="${_email_arguments[1]}"
    if [[ -e "${HOME}/.mutt/accounts/${_email_address}.sh" ]]
    then
      # Run in a subshell to avoid polluting the current shell environment.
      (
        source "${HOME}/.mutt/accounts/${_email_address}.sh"
        "$MUTT_COMMAND"
      )
    else
      printf "Account not found: %s\n" "${_email_address}"
      return 1
    fi
  fi
}