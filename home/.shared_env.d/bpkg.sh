###############################################################################
# bpkg
#
# Lightweight bash package manager
#
# http://bpkg.io/
# https://github.com/bpkg/bpkg
###############################################################################

# Since $PREFIX is set to .bpkg in `bpkg-packages`, add `~/.bpkg/bin` and
# `~/.bpkg/man` to `$PATH` and $MANPATH`.
PATH="$PATH:$HOME/.bpkg/bin"
export PATH
MANPATH="$HOME/.bpkg/man:$MANPATH"
export MANPATH
