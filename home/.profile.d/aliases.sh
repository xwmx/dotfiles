# Web -------------------------------------------------------------------------

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

# IP addresses
ip() {
  dig +short myip.opendns.com @resolver1.opendns.com
}
localip() {
  ipconfig getifaddr en0
}

# URL-encode strings
urlencode() {
  python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);" "$@"
}

# Apps ------------------------------------------------------------------------

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
chromekill() {
  ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill
}

# Shell -----------------------------------------------------------------------

# Reload the shell (i.e. invoke as a login shell)
reload_shell() {
  exec "$SHELL" -l
}

# Search commandline fu for snippits matching the input.
#
# Usage:
#   cmdfu du
cmdfu(){
  curl "http://www.commandlinefu.com/commands/matching/$*/""$(echo -n "$@" | openssl base64)""/plaintext"
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

# Disk / Storage --------------------------------------------------------------

# Prints the top 10 subdirectories by disk uage.
#
# http://oreilly.com/pub/h/15
#
# Usage:
#   ducks
ducks() {
  du -cks ./* | sort -rn | head -11
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
