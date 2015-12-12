###############################################################################
# Functions
###############################################################################

# Apps ------------------------------------------------------------------------

# chromekill()
#
# Usage:
#   chromekill
#
# Description:
#   Kill all "Chrome Helper" renderer processes (and, therefore, browser tabs)
#   in order to free up memory.
chromekill() {
  pgrep -f '[C]hrome Helper --type=renderer' | xargs kill
}

# Archives / Compression ------------------------------------------------------

# gz()
#
# Usage:
#   gz <path/to/file>
#
# Description:
#   Compare original and gzipped file size.
gz() {
  local origsize
  local gzipsize
  local ratio

  origsize=$(wc -c < "$1")
  gzipsize=$(gzip -c "$1" | wc -c)
  ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)

  printf "orig: %d bytes\n" "$origsize"
  printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# targz()
#
# Usage:
#   targz <path/to/file>
#
# Description:
#   Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression.
targz() {
  local tmpFile="${@%/}.tar"
  tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1

  size=$(
    stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
    stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
  );

  local cmd="";
  if (( size < 52428800 )) && hash zopfli 2> /dev/null
  then
    # the .tar file is smaller than 50 MB and Zopfli is available; use it
    cmd="zopfli"
  else
    if hash pigz 2> /dev/null
    then
      cmd="pigz"
    else
      cmd="gzip"
    fi
  fi

  echo "Compressing .tar using \`${cmd}\`…"
  "${cmd}" -v "${tmpFile}" || return 1
  [ -f "${tmpFile}" ] && rm "${tmpFile}"
  echo "${tmpFile}.gz created successfully."
}

# Date / Time -----------------------------------------------------------------

# utc_timestamp()
#
# Usage:
#   utc_timestamp
#
# Description:
#   Print a UTC timestamp.
utc_timestamp() {
  date -u "+%Y%m%d%H%M%S"
}

# utcts()
#
# Usage:
#   utcts
#
# Description:
#   Shortcut for `utc_timestamp`: Print a UTC timestamp.
utcts() {
  utc_timestamp
}

# week()
#
# Usage:
#   week
#
# Description:
#   Get week number.
week() {
  date +%V
}

# timer()
#
# timer
#
# Description:
#   Stopwatch.
timer() {
  printf "Timer started. Stop with Ctrl-D.\n" &&
    date &&
    time cat &&
    date
}

# epoch()
#
# Description:
#   Epoch time conversion.
epoch() {
  TESTREG="[\d{10}]"
  if [[ "$1" =~ $TESTREG ]]
  then
    # is epoch
    date -d @$*
  else
    # is date
    if [ $# -gt 0 ]
    then
      date +%s --date="$*"
    else
      date +%s
    fi
  fi
}

# Edit / Open Shortcuts -------------------------------------------------------

# # s()
# #
# # Usage:
# #   s [<path>]
# #
# # Description:
# #   `s` with no arguments opens the current directory in Sublime Text,
# #   otherwise opens the given location.
# s() {
#   if [ $# -eq 0 ]
#   then
#     subl .
#   else
#     subl "$@"
#   fi
# }
#
# # a()
# #
# # Usage:
# #   a [<path>]
# #
# # Description:
# #   `a` with no arguments opens the current directory in Atom Editor,
# #   otherwise opens the given location.
# a() {
#   if [ $# -eq 0 ]
#   then
#     atom .
#   else
#     atom "$@"
#   fi
# }
#
# # v()
# #
# # Usage:
# #   v [<path>]
# #
# # Description:
# #   `v` with no arguments opens the current directory in Vim, otherwise opens
# #   the given location.
# v() {
#   if [ $# -eq 0 ]
#   then
#     vim .
#   else
#     vim "$@"
#   fi
# }
#
# # o()
# #
# # Usage:
# #   o [<path>]
# #
# # Description:
# #   `o` with no arguments opens the current directory, otherwise opens the
# #   given location.
# o() {
#   if [ $# -eq 0 ]
#   then
#     open .
#   else
#     open "$@"
#   fi
# }

# Filesystem ------------------------------------------------------------------

# ducks()
#
# Usage:
#   ducks
#
# Description:
#   Print the top 10 subdirectories by disk uage. More information:
#   http://oreilly.com/pub/h/15
ducks() {
  du -cks ./* | sort -rn | head -11
}

# tre()
#
# Usage:
#   tre [<options>] [<arguments>]
#
# Description:
#   Enhanced `tree`.
tre() {
  _print_tre_help() {
    cat <<HEREDOC
Usage:
  tre [-f | -h | -n | -t | -Q | --dirsfirst] [--sort <type>] [-r] [-L <level>]
      [-I pattern] [-P pattern] [--ignore-case] [<tree arguments>] [<path>]
  tre --help

Option:
  -f             Print the full path prefix for each file.
  -h             Print the size in a more human readable way.
  -n             Display line numbers.
  -t             Sort files by last modification time.
  -Q             Quote filenames with double quotes.
  --dirsfirst    List directories before files.
  --sort <type>  Select sort: name,version,size,mtime,ctime.
  -r             Reverse the order of the sort.
  -L <level>     Max display depth of the directory tree.
  -I <pattern>   Do not list files that match the given pattern.
  -P <pattern>   List only those files that match the pattern given.
  --ignore-case  Ignore case when pattern matching
  --help         Show this help.

Description:
  \`tre\` is a shorthand for \`tree\` with hidden files and color enabled,
  ignoring administrative directories like \`.git\`, and listing directories
  first. The output gets piped into \`less\` for paging when the output is
  more than one page.

  Additional \`tree\` options can be used. For more information, see
  \`tree --help\` and \`man tree\`.
HEREDOC
  }

  local _less_options="-FRX"
  local -a _tree_arguments
  _tree_arguments=()

  for arg in "${@}"
  do
    case $arg in
      --help)
        _print_tre_help
        return 0
        ;;
      -n)
        _less_options="${_less_options}N"
        ;;
      *)
        _tree_arguments+=("$arg")
        ;;
    esac
  done

  tree \
    -aC \
    -I '.git|node_modules|bower_components' \
    "${_tree_arguments[@]}" \
    | less "${_less_options}"
}

# fs()
#
# Usage:
#   fs [<path>]
#
# Description:
#   Determine size of a file or total size of a directory.
fs() {
  local _du_command="du"
  local -a _du_options

  # Use `gdu` if it's available.
  if hash "gdu" 2>/dev/null
  then
    _du_command="gdu"
  fi

  if "$_du_command" -b /dev/null > /dev/null 2>&1
  then # GNU
    _du_options=(-sbh)
  else # BSD
    # OS X `du` has no `-b` equivalent, so the sizes it displays are not the
    # same as the "apparent" size as viewed by applications.
    _du_options=(-sh)
  fi

  if [[ -n "$@" ]]
  then
    "$_du_command" "${_du_options[@]}" -- "$@"
  else
    "$_du_command" "${_du_options[@]}"
  fi
}

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

# Git / GitHub ----------------------------------------------------------------

# diff()
#
# Description:
#   Use Git’s colored diff when available.
if hash git &>/dev/null
then
  diff() {
    git diff --no-index --color-words "$@"
  }
fi

# gitio()
#
# Usage:
#   gitio <slug> <url>
#
# Description:
#   Create a git.io short URL
gitio() {
  if [ -z "${1}" ] || [ -z "${2}" ]
  then
    echo "Usage: gitio <slug> <url>"
    return 1
  fi
  curl -i http://git.io/ -F "url=${2}" -F "code=${1}"
}

# JSON ------------------------------------------------------------------------

# json()
#
# Usage:
#   json '{"foo":42}'
#   echo '{"foo":42}' | json
#
# Description:
#   Syntax-highlight JSON strings or files
json() {
  if [ -t 0 ]
  then # argument
    printf "%s" "$*" | python -mjson.tool | pygmentize -l javascript
  else # pipe
    python -mjson.tool | pygmentize -l javascript
  fi
}

# Network & Web ---------------------------------------------------------------

# __lwp_request_m()
#
# Usage:
#   __lwp_request_m "VERB" <url> [<arguments>]
#
# Description:
#   Perform an HTTP request using `lwp-request -m`. If `ccat` or `pygmentize`
#   are present, pipe through that to provide some color.
__lwp_request_m() {
  local _lwp_cat_cmd
  local _lwp_method
  if hash ccat 2> /dev/null
  then
    _lwp_cat_cmd="ccat"
  elif hash pygmentize 2> /dev/null
  then
    _lwp_cat_cmd="pygmentize"
  else
    _lwp_cat_cmd="cat"
  fi
  _lwp_method="$1"
  shift
  lwp-request -m "$_lwp_method" "${*}" | "$_lwp_cat_cmd"
}
# One of @janmoesen’s ProTip™s
GET()     { __lwp_request_m "GET" "$*";     }
HEAD()    { __lwp_request_m "HEAD" "$*";    }
POST()    { __lwp_request_m "POST" "$*";    }
PUT()     { __lwp_request_m "PUT" "$*";     }
DELETE()  { __lwp_request_m "DELETE" "$*";  }
TRACE()   { __lwp_request_m "TRACE" "$*";   }
OPTIONS() { __lwp_request_m "OPTIONS" "$*"; }

# digg()
#
# Usage:
#   digg <domain>
#
# Description:
#   Run `dig` and display the most useful info. If `ccat` is present, pipe
#   through that to provide some color.
digg() {
  local _cat_cmd
  if hash ccat 2> /dev/null
  then
    _cat_cmd="ccat"
  else
    _cat_cmd="cat"
  fi
  dig +nocmd "$1" any +multiline +noall +answer | "$_cat_cmd"
}

# urlencode()
#
# Usage:
#   urlencode <string>
#
# Description:
#   URL-encode strings
urlencode() {
  python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);" "$*"
}

# server()
#
# Usage:
#   server [<port>]
#
# Description:
#   Start an HTTP server from a directory, optionally specifying the port.
#   When no port is specified, the default port is '8080'.
server() {
  local port="${1:-8080}"
  # Set the default Content-Type to `text/plain` instead of
  # `application/octet-stream` and serve everything as UTF-8 (although not
  # technically correct, this doesn’t break anything for binary files)
  local server_script
  read -r -d '' server_script <<HEREDOC
import SimpleHTTPServer
map = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map
map[""] = "text/plain"
for key, value in map.items():
    map[key] = value + ";charset=UTF-8"
    SimpleHTTPServer.test()
HEREDOC
  python -c "$server_script" "$port"
}

# phpserver()
#
# Usage:
#   phpserver [<port>]
#
# Description:
#   Start a PHP server from a directory, optionally specifying the port
#   (Requires PHP 5.4.0+.), and open the location in the browser.
phpserver() {
  local port="${1:-4000}"
  local ip
  ip=$(ipconfig getifaddr en1)
  sleep 1 && open "http://${ip}:${port}/" &
  php -S "${ip}:${port}"
}

# getcertnames()
#
# Usage:
#   getcertnames <domain>
#
# Description:
#   Show all the names (CNs and SANs) listed in the SSL certificate for a
#   given domain
getcertnames() {
  if [ -z "${1}" ]
  then
    echo "ERROR: No domain specified."
    return 1
  fi

  local domain="${1}"
  echo "Testing ${domain}…"
  echo "" # newline
  local tmp
  tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
    | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1)

  if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]
  then
    local certText
    certText=$(echo "${tmp}" \
      | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
      no_serial, no_sigdump, no_signame, no_validity, no_version")
    echo "Common Name:"
    echo "" # newline
    echo "${certText}" \
      | grep "Subject:" \
      | sed -e "s/^.*CN=//" \
      | sed -e "s/\/emailAddress=.*//"
    echo "" # newline
    echo "Subject Alternative Name(s):"
    echo "" # newline
    echo "${certText}" \
      | grep -A 1 "Subject Alternative Name:" \
      | sed -e "2s/DNS://g" -e "s/ //g" \
      | tr "," "\n" \
      | tail -n +2
    return 0
  else
    echo "ERROR: Certificate not found."
    return 1
  fi
}

# Shell -----------------------------------------------------------------------

# reload()
#
# Usage:
#   reload
#
# Description:
#   Reload the shell (i.e. invoke as a login shell).
reload() {
  exec "$SHELL" -l
}

# badge()
#
# Usage:
#   badge
#
# Description:
#   Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
#   (useful when executing time-consuming commands).
badge() {
  tput bel
}

# map()
#
# Usage:
#   <command> | map <command>
#
# Description:
#   Intuitive map function
#
#   For example, to list all directories that contain a certain file:
#   find . -name .gitattributes | map dirname
map() {
  xargs -n1 "$@"
}

# show()
#
# Usage:
#   show <../path/to/file>
#   show <command>
#   show -h | --help
#
# Description:
#   When given a valid file path, the `ls` output is displayed for that file,
#   otherwise display the output of `which`.
#
# TODO: Add tab completion.
show() {
  if [[ "--help" == "$1" ]] || [[ "-h" == "$1" ]] || [[ -z "$1" ]]
  then
    cat <<HEREDOC
Usage:
  show <../path/to/file>
  show <command>
  show -h | --help

Description:
  When given a valid file path, the \`ls\` output is displayed for that file,
  otherwise display the output of \`which\`.
HEREDOC
    return 0
  fi

  if [[ -e "$1" ]]
  then
    if hash "exa" 2>/dev/null
    then
      exa \
        --long \
        --all \
        --list-dirs \
        --git \
        "$1"
    else
      ls -lahd "$1"
    fi
  else
    which "$1"
  fi
}

# Unicode ---------------------------------------------------------------------

# u()
#
# Usage:
#   u <command>
#   u -h | -help
#
# Description:
#   A shortcut for the unicode program.
u() {
  unicode "$@"
}

# Utilities -------------------------------------------------------------------

# shell_calc()
#
# Usage:
#   shell_calc <arguments>
#
# Description:
#   Simple calculator.
shell_calc() {
  local result=""
  result="$(printf "scale=10;%s\n" "$*" | bc --mathlib | tr -d '\\\n')"
  #                       └─ default (when `--mathlib` is used) is 20
  #
  if [[ "$result" == *.* ]]
  then
    # improve the output for decimal numbers
    printf "%s" "$result" |
    sed -e 's/^\./0./'       \ # add "0" for cases like ".5"
        -e 's/^-\./-0./'     \ # add "0" for cases like "-.5"
        -e 's/0*$//;s/\.$//'   # remove trailing zeros
  else
    printf "%s" "$result"
  fi
  printf "\n"
}
