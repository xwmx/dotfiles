###############################################################################
# fs_filesize.sh
###############################################################################

# fs()
#
# Usage:
#   fs [<arguments>]
#
# Description:
#   A cross-platform file size utility wrapping `du`.
fs() {
  _print_fs_help() {
    cat <<HEREDOC
Usage:
  fs [-a | --all | -l | --list [-n]] [<path>]
  fs -h | --help

Options:
  -a --all   List all files and directories in the subtree sorted by size
             descending and display in \`less\`.
  -l --list  When provided with a path to a directory, list the top level of
             contents with the total size of each item sorted by sizes
             descending and display in \`less\`.
  -n         Display line numbers.
  -h --help  Show this help.

Description:
  A cross-platform file size utility wrapping `du`. Determine sizes of files
  and total sizes of directories.
HEREDOC
  }

  local _du_command="du"
  local _sort_command="sort"
  local _cat_cmd="cat"
  local _list_all=0
  local _list_contents=0
  local _less_options="-FRX"
  local -a _du_options
  local -a _sort_options
  local -a _fs_arguments
  _fs_arguments=()

  for arg in "${@:-}"
  do
    case $arg in
      -h|--help)
        _print_fs_help
        return 0
        ;;
      -a|--all)
        _list_all=1
        ;;
      -l|--list)
        _list_contents=1
        ;;
      -n)
        _less_options="${_less_options}N"
        ;;
      *)
        _fs_arguments+=("$arg")
        ;;
    esac
  done

  # Use `gdu` if it's available.
  if hash "gdu" 2>/dev/null
  then
    _du_command="gdu"
  fi

  # Use `gsort` if it's available.
  if hash "gsort" 2>/dev/null
  then
    _sort_command="gsort"
  fi

  # Use `ccat` to generate color if it's available.
  # https://github.com/jingweno/ccat
  # At this time, `pygmentize`, another syntax highlighter, doesn't work
  # well for this content.
  if hash "ccat" 2>/dev/null
  then
    _cat_cmd="ccat -C 'always'"
  fi

  if "$_du_command" -b /dev/null > /dev/null 2>&1
  then # GNU
    if ((_list_contents))
    then
      _du_options=(-ha --max-depth 1)
    elif ((_list_all))
    then
      _du_options=(-ha)
    else
      _du_options=(-sbh)
    fi
  else # BSD
    # OS X `du` has no `-b` equivalent, so the sizes it displays are not the
    # same as the "apparent" size as viewed by applications, and it has no
    # equivalent to GNU `du -a`.
    if ((_list_contents))
    then
      _du_options=(-h -d 1)
    elif ((_list_all))
    then
      _du_options=(-h -a)
    else
      _du_options=(-sh)
    fi
  fi

  if "$_sort_command" -h /dev/null > /dev/null 2>&1
  then # GNU
    _sort_options=(-hr)
  else # BSD
    # BSD `sort` doesn't have `-h` so the sort results in ordering like:
    # 10K, 5M, 1K. Therefore, only use this as a fallback.
    _sort_options=(-nr)
  fi

  if [[ -n "$@" ]]
  then
    if ((_list_all)) || ((_list_contents))
    then
      "$_du_command" "${_du_options[@]}" -- "${_fs_arguments[@]}" \
        | "$_sort_command" "${_sort_options[@]}" \
        | eval "$_cat_cmd" \
        | less "${_less_options}"
    else
      "$_du_command" "${_du_options[@]}" -- "${_fs_arguments[@]}"
    fi
  else
    if ((_list_all)) || ((_list_contents))
    then
      "$_du_command" "${_du_options[@]}" \
        | "$_sort_command" "${_sort_options[@]}" \
        | eval "$_cat_cmd" \
        | less "${_less_options}"
    else
      "$_du_command" "${_du_options[@]}"
    fi
  fi
}
