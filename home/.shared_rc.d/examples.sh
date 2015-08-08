###############################################################################
# examples / eg
#
# Shell functions for displaying usage examples for Unix / Linux commands.
###############################################################################

# examples()
#
# Usage:
#   examples <utility>
#
# Description:
#   Print the "examples" section of the given utility's man page.
examples(){
  if [[ -z "${1:-}" ]]
  then
    printf "Usage: examples <utility>\n"
    return 1
  elif [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]
  then
    printf "\
Usage:
  examples <utility>

Description:
  Print the \"examples\" section of the utility's man page.
"
    return 0
  fi

  local _sed_cmd
  if hash "gsed" 2>/dev/null
  then
    _sed_cmd="gsed"
  else
    _sed_cmd="sed"
  fi
  MAN_KEEP_FORMATTING=1 man "$@" 2>/dev/null \
    | "$_sed_cmd" \
      --quiet \
      --expression='/^E\(\x08.\)X\(\x08.\)\?A\(\x08.\)\?M\(\x08.\)\?P\(\x08.\)\?L\(\x08.\)\?E/{:a;p;n;/^[^ ]/q;ba}' \
    | ${MANPAGER:-${PAGER:-pager -s}}
}


# eg()
#
# Usage:
#   eg <command>
#
# Description:
#   Display usage examples for a given command. If the "bro pages"
#   (http://bropages.org/) Ruby gem is installed on the system, then this
#   function will use that, otherwise the `examples` shell function is used.
eg() {
  if [[ -z "${1:-}" ]]
  then
    printf "Usage: eg <command>\n"
    return 1
  elif [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]
  then
    printf "\
Usage:
  eg <command>

Description:
  Display usage examples for a given command. If the \"bro pages\"
  (http://bropages.org/) Ruby gem is installed on the system, then this
  function will use that, otherwise the \`examples\` shell function is used.
"
    return 0
  fi

  if hash "bro" 2>/dev/null
  then
    bro "$@"
  else
    examples "$@"
  fi
}


# cmdfu()
#
# Usage:
#   cmdfu [<command search term>]
#
# Description:
#   Search commandlinefu.com for snippits matching the input.
cmdfu(){
  if [[ -z "${1:-}" ]]
  then
    printf "Usage: cmdfu [<command search term>]\n"
    return 1
  elif [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]
  then
    printf "\
Usage:
  cmdfu [<command search term>]

Description:
  Search commandlinefu.com for snippits matching the input.
"
    return 0
  fi

  local search_term
  local stripped_term
  local hashed_term
  local commandlinefu_url
  search_term="$*"
  stripped_term="$(printf "%s" "$search_term" | tr -d "[:space:]")"
  hashed_term="$(printf "%s" "$search_term" | openssl base64)"
  commandlinefu_url="$(printf \
    "http://www.commandlinefu.com/commands/matching/%s/%s/plaintext" \
    "$stripped_term" \
    "$hashed_term")"
  curl "$commandlinefu_url"
}
