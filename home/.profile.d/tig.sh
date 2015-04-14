###############################################################################
# tig
#
# Text-mode interface for git
#
# http://jonas.nitro.dk/tig/
# https://github.com/jonas/tig
#
# See also: $HOME/.tigrc
###############################################################################

# tiga()
#
# Usage:
#   tiga
#
# Description:
#   Run `tig` with the `--all` flag, which includes all branches in the default
#   view.
tiga() {
  tig --all
}
