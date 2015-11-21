###############################################################################
# cd.sh
#
# Shortcuts for `cd` navigation.
###############################################################################

# cde()
#
# Usage:
#   cde <path>
#
# Description:
#   Change to the given directory and run `exa`.
cde() {
  cd "${1:-}" || return
  exa -la --git
}

# cdf()
#
# Usage:
#   cdf
#
# Description:
#   Change working directory to the top-most Finder window location. `cdf` is
#   short for 'cdfinder'.
#
#   NOTE: macOS only.
if [[ "$OSTYPE" =~ ^darwin ]]
then
  cdf() {
    local _script
    _script='tell app "Finder" to POSIX path of (insertion location as alias)'
    cd "$(osascript -e "$_script")" || return
  }
fi

# cdl()
#
# Usage:
#   cdl <path>
#
# Description:
#   Change to the given directory and run `ls`.
cdl() {
  cd "${1:-}" || return
  ls -lah
}

# mkd()
#
# Usage:
#   mkd <path>
#
# Description:
#   Create a new directory with `mkdir -p` and enter it.
mkd() {
  mkdir -p "$@" && cd "$_" || return
}
