###############################################################################
# hd_hexdump.sh
###############################################################################

# hd()
#
# Usage:
#   hd [-n] <path/to/file>
#
# Options:
#   -n  Show line numbers.
#
# Description:
#   Canonical hex dump with color and `less`.
#
#   NOTE: some popular operating systems use `hd` as a symlink to `hexdump`,
#   so don't define the function if `hd` already exists.
if ! hash "hd" 2>/dev/null
then
  hd() {
    _print_hd_help() {
      cat <<HEREDOC
Usage:
  hd [-n] <path/to/file>
  hd -h | --help

Options:
  -n         Show line numbers.
  -h --help  Show this help.

Description:
  Canonical hex dump with color and \`less\`.
HEREDOC
    }

    local _cat_cmd="cat"
    local _less_options="-FRX"
    local -a _hexdump_arguments
    _hexdump_arguments=()

    # Use `ccat` to generate color if it's available.
    # https://github.com/jingweno/ccat
    # At this time, `pygmentize`, another syntax highlighter, doesn't work
    # well for this content.
    if hash "ccat" 2>/dev/null
    then
      _cat_cmd="ccat -C 'always'"
    fi

    for arg in "${@:-}"
    do
      case $arg in
        -h|--help)
          _print_hd_help
          return 0
          ;;
        -n)
          _less_options="${_less_options}N"
          ;;
        *)
          _hexdump_arguments+=("$arg")
          ;;
      esac
    done

    if [[ -z "${_hexdump_arguments[@]:-}" ]]
    then # there are not arguments.
      _print_hd_help
      return 0
    fi

    hexdump \
      -C \
      "${_hexdump_arguments[@]}" \
      | eval "$_cat_cmd" \
      | less "${_less_options}"
  }
fi
