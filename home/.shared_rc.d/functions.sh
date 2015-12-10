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
#   gz [<file path>]
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

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
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

# Print a UTC timestamp
#
# Usage:
#   utc_timestamp
utc_timestamp() {
  date -u "+%Y%m%d%H%M%S"
}
utcts() {
  utc_timestamp
}

# Get week number
week() {
  date +%V
}

# Stopwatch
timer() {
  printf "Timer started. Stop with Ctrl-D.\n" && date && time cat && date
}

# Epoch time conversion
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

# # `s` with no arguments opens the current directory in Sublime Text, otherwise
# # opens the given location
# s() {
#   if [ $# -eq 0 ]; then
#     subl .
#   else
#     subl "$@"
#   fi
# }
#
# # `a` with no arguments opens the current directory in Atom Editor, otherwise
# # opens the given location
# a() {
#   if [ $# -eq 0 ]; then
#     atom .
#   else
#     atom "$@"
#   fi
# }
#
# # `v` with no arguments opens the current directory in Vim, otherwise opens the
# # given location
# v() {
#   if [ $# -eq 0 ]; then
#     vim .
#   else
#     vim "$@"
#   fi
# }
#
# # `o` with no arguments opens the current directory, otherwise opens the given
# # location
# o() {
#   if [ $# -eq 0 ]; then
#     open .
#   else
#     open "$@"
#   fi
# }

# Filesystem ------------------------------------------------------------------

# Prints the top 10 subdirectories by disk uage.
#
# http://oreilly.com/pub/h/15
#
# Usage:
#   ducks
ducks() {
  du -cks ./* | sort -rn | head -11
}

# tre()
#
# Usage:
#   tre [-n] [<path>]
#
# Option:
#   -n  Display line numbers.
#
# Description:
#   `tre` is a shorthand for `tree` with hidden files and color enabled,
#   ignoring administrative directories like `.git`, and listing directories
#   first. The output gets piped into `less` for paging when the output is
#   more than one page.
tre() {
  if [[ "${1:-}" == "--help" ]] || [[ "${1:-}" == "-h" ]]
  then
    cat <<HEREDOC
Usage:
  tre [-n] [<path>]

Option:
  -n  Display line numbers.

Description:
  \`tre\` is a shorthand for \`tree\` with hidden files and color enabled,
  ignoring administrative directories like \`.git\`, and listing directories
  first. The output gets piped into \`less\` for paging when the output is
  more than one page.
HEREDOC
    return 0
  fi

  local _less_options="-FRX"
  local _tree_path="."

  for arg in "${@}"
  do
    case $arg in
      -n)
        _less_options="${_less_options}N"
        ;;
      *)
        if [[ "$_tree_path" == "." ]]
        then
          _tree_path="$arg"
        fi
        ;;
    esac
  done

  tree \
    -aC \
    -I '.git|node_modules|bower_components' \
    --dirsfirst \
    "${_tree_path}" \
    | less "${_less_options}"
}

# Determine size of a file or total size of a directory
fs() {
  if du -b /dev/null > /dev/null 2>&1
  then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]
  then
    du $arg -- "$@"
  else
    du $arg .[^.]* ./*;
  fi
}

# Git / GitHub ----------------------------------------------------------------

# Use Git’s colored diff when available
if hash git &>/dev/null
then
  diff() {
    git diff --no-index --color-words "$@";
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

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
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
  local port="${1:-8000}";
  # Set the default Content-Type to `text/plain` instead of
  # `application/octet-stream` and serve everything as UTF-8 (although not
  # technically correct, this doesn’t break anything for binary files)
  local server_script
  server_script=$(printf "\
import SimpleHTTPServer
map = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map
map[\"\"] = \"text/plain\"
for key, value in map.items():
    map[key] = value + \";charset=UTF-8\"
    SimpleHTTPServer.test()
")
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

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
getcertnames() {
  if [ -z "${1}" ]; then
    echo "ERROR: No domain specified."
    return 1
  fi

  local domain="${1}"
  echo "Testing ${domain}…"
  echo "" # newline

  local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
    | openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1)

  if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]
  then
    local certText=$(echo "${tmp}" \
      | openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
      no_serial, no_sigdump, no_signame, no_validity, no_version")
    echo "Common Name:"
    echo "" # newline
    echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//"
    echo "" # newline
    echo "Subject Alternative Name(s):"
    echo "" # newline
    echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
      | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
    return 0
  else
    echo "ERROR: Certificate not found."
    return 1
  fi
}

# Shell -----------------------------------------------------------------------

# Reload the shell (i.e. invoke as a login shell)
reload() {
  exec "$SHELL" -l
}

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
badge() {
  tput bel
}

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
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

# A shortcut for the unicode program.
u() {
  unicode "$@"
}

# Utilities -------------------------------------------------------------------

# Simple calculator
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
