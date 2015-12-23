#!/usr/bin/env bash
# NOTE: zsh required. The bash shebang is only for shellcheck.
###############################################################################
# defined
#
# Reveal where functions, aliases, variables, and other shell environment
# items are defined.
###############################################################################

# defined()
#
# Usage:
#   defined [ -wfpamsS ] [--describe] <name>
#   defined --debug-init
#   defined -h | --help
defined() {
  _print_defined_function_help() {
    cat <<HEREDOC
Where is <name> \`defined\`?

Usage:
  defined [ -wfpamsS ] [--describe] <name>
  defined --debug-init
  defined -h | --help

Options:
  --describe    Display additional descriptive information about the name.
  --debug-init  Print shell init info from \`zsh -x\`.
  -h --help     Show this help.

Description:
  Show where a function, alias, variable, or executable is defined. Uses
  \`type\` when possible.

  NOTE: For variables, use a leading backslash, eg, \`\\\$NAME\`.
HEREDOC
  }

  local _type_results
  local _login_command="zsh -x -lsi -c 'exit' 2>&1"
  local -a _defined_arguments
  local _describe=0
  local _description_heading="# Description"

  for arg in "${@:-}"
  do
    case $arg in
      -h|--help)
        _print_defined_function_help
        return 0
        ;;
      --debug-init)
        eval "$_login_command"
        return 0
        ;;
      --describe)
        _describe=1
        ;;
      *)
        _defined_arguments+=("$arg")
        ;;
    esac
  done

  local _query="${_defined_arguments[1]:-}"

  if [[ "$_query" =~ ^\\\$ ]]
  then # variable
    local _normalized_name
    printf "%s\n" "${_query}" \
      | sed 's/^\$//'         \
      | read -r -d '' _normalized_name

    eval "$_login_command"          \
      | grep                        \
        -e "> ${_normalized_name}=" \
        -e "> export ${_normalized_name}="
    if ((_describe))
    then
      local _value
      eval "_value=${_query}"
      cat <<HEREDOC
${_description_heading}
${_query}
${_value}
HEREDOC
    fi
  else # not a variable
    _type_results="$(type "${_query}")"

    if [[ "${_type_results}" =~ not\ found ]]
    then # not found
      return 1
    elif [[ "${_type_results}" =~ is\ an\ alias\ for ]]
    then # alias
      eval "$_login_command"      \
        | grep                    \
          -e "alias '${_query}="  \
          -e "alias ${_query}="
    else # function, executable
      printf "%s\n" "${_type_results}"
    fi

    if ((_describe))
    then
      printf "%s\n" "$_description_heading"
      which "$_query"
    fi
  fi
}
