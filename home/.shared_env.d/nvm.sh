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
# the source line to move install location and prevent this.
#
# NOTE: When ~/.nvm is a symlink and `$NVM_DIR` is set to that location,
# various errors can occur. There is currently an open issue related to this:
#
# https://github.com/creationix/nvm/issues/617
#
#  One error encountered in this configuration is the following:
# 'nvm is not compatible with the npm config "prefix" option: currently set to "<path>"'.
# In this case, the warning appears to be triggered by this check:
#
# https://github.com/creationix/nvm/blob/04c5e3540eda71360470c6bd0ef850fefed7190c/nvm.sh#L1356
#
# This issue can be resolved by using `readlink`, as noted in this comment:
#
# https://github.com/creationix/nvm/issues/855#issuecomment-160232254
#
# `readlink` ensures that `$NVM_NPM_PREFIX` will correctly match as a
# subdirectory of `$NVM_DIR`.
export NVM_DIR="$(readlink "${HOME}/.nvm")"

. "${HOME}/.nvm/nvm.sh"
