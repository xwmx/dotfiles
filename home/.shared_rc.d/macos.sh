###############################################################################
# A collection of shell functions for macOS only.
###############################################################################

# Automator -------------------------------------------------------------------

mergepdf() {
  _usage="Usage: mergepdf -o output.pdf input{1,2,3}.pdf"
  if [ $# -eq 0 ]; then
    printf "%s\n" "$_usage"
    return 0
  fi
  case "$1" in
    -h|--help)
      printf "%s\n" "$_usage"
      ;;
    *)
      /System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py "$@"
      ;;
  esac
}

# Clipboard -------------------------------------------------------------------

# Copy the current pwd (working directory) to the clipboard.
cpwd() {
  pwd | xargs echo -n | pbcopy
}

# Trim new lines and copy to clipboard
clean_copy() {
  tr -d '\n' | pbcopy
}

# Finder ----------------------------------------------------------------------

# Hide/show hidden files in Finder
# Recursively delete `.DS_Store` files
clean_ds_store() {
  find . -type f -name '*.DS_Store' -ls -delete
}

# finder()
#
# Usage:
#   finder <path>
#
# Description:
#   Open the given path in the finder. Alias for `open -R`.
finder() {
  local _path="${1:-}"
  if [[ -z "$_path" ]]
  then
    printf "Usage: finder <path>\n"
    return 1
  elif [[ ! -e "$_path" ]]
  then
    printf "Nothing exists at the given path:\n%s\n" "$_path"
    return 1
  else
    open -R "$_path"
  fi
}

# Shell -----------------------------------------------------------------------

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"
