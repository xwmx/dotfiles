###############################################################################
# Go
#
# Go is an open source programming language that makes it easy to build simple,
# reliable, and efficient software.
#
# https://golang.org/
###############################################################################

# homebrew-install GOROOT
export GOROOT=/usr/local/opt/go/libexec
# Add GOROOT bin to path
PATH=$PATH:$GOROOT/bin

# $GOPATH
#
# In order to separate go projects from whatever particular install method is
# being used at any time, $GOPATH and everything related to it are set to
# $HOME/.go with the intention that symlinks are created in external
# directories that need to be aware of where something in $GOPATH is located.
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin
# Add all $GOPATH/bin directories.
#
# Snippet via: https://code.google.com/p/go-wiki/wiki/GOPATH
PATH=$PATH:${GOPATH//://bin:}/bin

export PATH
