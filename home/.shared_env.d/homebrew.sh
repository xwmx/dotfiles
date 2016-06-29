###############################################################################
# .shared_env.d/homebrew.sh
#
# Configuration for Homebrew.
#
# http://brew.sh/
###############################################################################

# Analytics
#
# Disable homebrew analytics.
#
# https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
# https://news.ycombinator.com/item?id=11566720
export HOMEBREW_NO_ANALYTICS=1

# Caskroom location
#
# The default Caskroom location has moved to /usr/local/Caskroom. There are
# reports of issues with some casks not working with the new location, so
# set the old location as the default using the `$HOMEBREW_CASK_OPTS`
# environment variable.
#
# NOTE: There is an open issue to remove the `--caskroom` option and
# Homebrew Cask's implementation is in flux, so revisit this and update
# as needed.
#
# Resources:
# https://github.com/caskroom/homebrew-cask/blob/master/USAGE.md#options
# https://github.com/caskroom/homebrew-cask/issues/21913
# https://github.com/caskroom/homebrew-cask/issues/21858
export HOMEBREW_CASK_OPTS="--caskroom=/opt/homebrew-cask/Caskroom"
