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

# timestamp()
#
# Usage:
#   timestamp
#
# Description:
#   Shortcut for `utc_timestamp`: Print a UTC timestamp.
timestamp() {
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

# datetime
#
# Usage:
#   Natural language date/time parsing with Chronic:
#   https://github.com/mojombo/chronic/
datetime() {
  if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ -z "${1:-}" ]
  then
    cat <<HEREDOC
Usage:
  datetime <time query>
  datetime -h | --help

Options:
  -h --help  Display this usage information.

Description:
  Natural language date/time parsing with Chronic:
  https://github.com/mojombo/chronic/
HEREDOC
    if [ -z "${1:-}" ]
    then
      return 1
    else
      return 0
    fi
  fi

  ruby -e "require 'chronic'; puts Chronic.parse('${*}')"
}
alias dt="datetime"

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
#   gitio [<slug>] <url>
#
# Description:
#   Create a git.io short URL.
gitio() {
  if [[ -z "${1}" ]] || [[ "${1:-}" =~ '^-h|--help$'  ]]
  then
    printf "Usage: gitio [<slug>] <url>\n"
    return 1
  elif [[ -z "${2}" ]]
  then
    curl -i https://git.io/ -F "url=${1}"
  else
    curl -i https://git.io/ -F "url=${2}" -F "code=${1}"
  fi
}

# JSON ------------------------------------------------------------------------

# json()
#
# Usage:
#   json '{"foo":42}'
#   echo '{"foo":42}' | json
#
# Description:
#   Syntax-highlight JSON strings or files.
json() {
  local __command=

  if hash "jq" 2> /dev/null
  then
    __command="jq"
  elif hash "pygmentize" 2> /dev/null
  then
    __command="python -m json.tool | pygmentize -l javascript"
  else
    cat
  fi

  if [ -t 0 ]
  then # argument
    printf "%s" "$*" | eval "${__command}"
  else # pipe
    eval "${__command}"
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

# pause()
#
# Usage:
#   pause
#
# Description:
#   Pause whatever is happening until a key is pressed.
pause() {
  # The options used with `read` are not compatible with zsh, so fake it when
  # then shell isn't bash.
  local _command="read -rsp $'Press any key to continue...\n' -n1 key"
  if [[ "$SHELL" =~ bash ]]
  then
    eval "$_command"
  else
    bash -c "$_command"
  fi
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

# spellcheck()
#
# Usage:
#   spellcheck <word>
spellcheck() {
  if ! hash "aspell" &>/dev/null
  then
    printf "aspell is required.\n"
    return 1
  elif [[ "${1:-}" = "-h" ]] || [[ "${1:-}" = "--help" ]]
  then
    cat <<HEREDOC
Usage:
  spellcheck <word>
  spellcheck -h | --help

Options:
  -h --help  Display this usage information.

Description:
  Use \`aspell\` to spellcheck <word>.
HEREDOC
    return 0
  elif [[ -z "${1:-}" ]]
  then
    spellcheck -h
    return 1
  else
    _result="$(printf "%s\n" "${1}" | aspell -a | sed -n '2p')"
    if [[ "${_result}" =~ ^'\*' ]]
    then
      printf "✓\n"
    else
      printf "%s\n" "${_result}"
    fi
  fi
}
