###############################################################################
# nvm
#
# Node Version Manager - Simple bash script to manage multiple active node.js
# versions.
#
# https://github.com/creationix/nvm
#
# Configuration for homebrew-installed nvm
###############################################################################

# Node installs will be lost upon upgrading nvm. Add the following above
# the source line to move install location and prevent this:
export NVM_DIR=~/.nvm

. "$HOME"/.nvm/nvm.sh
