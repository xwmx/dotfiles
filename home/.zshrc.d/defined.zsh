#!/usr/bin/env bash
###############################################################################
# defined
#
# Reveal where functions and aliases are defined.
###############################################################################

# defined()
#
# Usage:
#   defined [ -wfpamsS ] <name>
#   defined --debug-init
#   defined -h | --help
defined() {
  _print_defined_function_help() {
    cat <<HEREDOC
Where is <name> \`defined\`?

Usage:
  defined [ -wfpamsS ] <name>
  defined --debug-init
  defined -h | --help

Options:
  --debug-init  Print shell init info from \`zsh -x\`.
  -h --help     Show this help.

Description:
  Show where a function, alias, variable, or executable is defined. Uses
  \`type\` when possible.

  NOTE: For variables, use a leading backslash, eg, \`\\\$NAME\`.
HEREDOC
  }

  local _query="${1}"
  local _type_results
  local _login_command="zsh -x -lsi -c 'exit' 2>&1"

  if [[ "$_query" == "-h" ]] || [[ "$_query" == "--help" ]]
  then
    _print_defined_function_help
    return 0
  elif [[ "$_query" == "--debug-init" ]]
  then
    eval "$_login_command"
    return 0
  fi

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
  else
    _type_results="$(type "${_query}")"

    if [[ "${_type_results}" =~ is\ an\ alias\ for ]]
    then # alias
      eval "$_login_command"      \
        | grep                    \
          -e "alias '${_query}="  \
          -e "alias ${_query}="
    else
      printf "%s\n" "${_type_results}"
    fi
  fi
}
