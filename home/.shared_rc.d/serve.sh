###############################################################################
# serve.sh
###############################################################################

# serve()
#
# Usage:
#   serve [<port>]
#
# Description:
#   Start an HTTP server from a directory, optionally specifying the port.
#   When no port is specified, the default port is '8080'.
serve() {
  _print_serve_help() {
    cat <<HEREDOC
Usage:
  serve [<port>]
  serve -h | --help

Description:
  Start an HTTP server from a directory, optionally specifying the port.
  When no port is specified, the default port is '8080'.
HEREDOC
  }

  if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]
  then
    _print_serve_help
    return 0
  fi

  if ! hash "python" 2>/dev/null
  then
    printf "Python is required, but a \`python\` executable was not found.\n"
    return 1
  fi

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
alias server='serve'

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
