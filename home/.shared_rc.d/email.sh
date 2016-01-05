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

# email()
#
# A wrapper interface for a multi-account mutt configuration.
email() {
  local _mutt_accounts_path="${HOME}/.mutt/accounts"

  # _email_print_help()
  #
  # Printf help and usage information.
  _email_print_help() {
    cat <<HEREDOC
Usage:
  email list
  email <account address> [<mutt arguments>]
  email -h | --help

Options:
  -h --help  Show this help.

Description:
  Simple interface for multi-account mutt.
HEREDOC
  }

  # _email_print_list()
  #
  # Print the available accounts.
  _email_print_list() {
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
  local _account_address=

  for arg in "${@:-}"
  do
    case $arg in
      -h|--help)
        _email_print_help
        return 0
        ;;
      list)
        _email_print_list
        return 0
        ;;
      *@*)
        if [[ -z "${_account_address:-}" ]]
        then
          _account_address="${arg}"
        else
          _email_arguments+=("$arg")
        fi
        ;;
      *)
        _email_arguments+=("$arg")
        ;;
    esac
  done

  # Verify that an account address was passed.
  if [[ -z "${_account_address:-}" ]]
  then
    _email_print_help
    return 1
  fi

  # Verify that the specified account exists.
  if [[ ! -e "${HOME}/.mutt/accounts/${_account_address}.sh" ]]
  then
    printf "Account not found.\n"
    return 1
  fi

  # Run in a subshell to avoid polluting the current shell environment.
  (
    # Source the appropriate account file.
    source "${HOME}/.mutt/accounts/${_account_address}.sh"

    # Confirm that all expected environment variables have been set.
    local -a _expected_variables
    _expected_variables=(
      MUTT_COMMAND
      MUTT_PROVIDER
      MUTT_ACCOUNT_EMAIL
      MUTT_ACCOUNT_REALNAME
      MUTT_ACCOUNT_PASSWORD
    )
    for _variable in ${_expected_variables[@]}
    do
      if [[ -z "$(eval "echo \$${_variable}")" ]]
      then
        printf "❌  %s has no assigned value.\n" "${_variable}"
        return 1
      fi
    done

    # Run mutt.
    if [[ -z "${_email_arguments[@]:-}" ]]
    then
      "$MUTT_COMMAND"
    else
      "$MUTT_COMMAND" "${_email_arguments[@]}"
    fi
  )
}
