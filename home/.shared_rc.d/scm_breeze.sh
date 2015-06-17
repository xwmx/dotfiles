###############################################################################
# scm_breeze.sh
#
# Environment settings for SCM Breeze. The SCM Breeze installation can be found
# at $HOME/.scm_breeze
#
# https://github.com/ndbroadbent/scm_breeze
###############################################################################

# Load scm_breeze.
#
# This line would have been added to the rc files by the
# $HOME/.scm_breeze/install.sh script.
#
# Additionally, 1>/dev/null silences the following message:
#   SCM Breeze must be loaded after RVM...
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && \
  source "$HOME/.scm_breeze/scm_breeze.sh" 1>/dev/null
