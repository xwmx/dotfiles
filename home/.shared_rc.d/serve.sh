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
#
# Big list of http static server one-liners:
#   https://gist.github.com/willurd/5720255
serve() {
  _print_serve_help() {
    cat <<HEREDOC
Usage:
  serve [<port>]
  serve -h | --help

Description:
  Start an HTTP server from a directory, optionally specifying the port.
  When no port is specified, the default port is '8080'.
  
Big list of http static server one-liners:
  https://gist.github.com/willurd/5720255
HEREDOC
  }

  if [[ "${1:-}" == "-h" ]] || [[ "${1:-}" == "--help" ]]
  then
    _print_serve_help
    return 0
  fi

  local _port="${1:-8080}"

  if hash "ruby" 2>/dev/null
  then
    ruby -run -e httpd . -p "${_port}"
  elif hash "python" 2>/dev/null
  then
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
    python -c "${server_script}" "${_port}"
  else
cat <<HEREDOC
Ruby or Python is required, but neither was found."
HEREDOC
    return 1
  fi
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
