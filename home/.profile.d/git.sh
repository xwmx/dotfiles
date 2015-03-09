###############################################################################
# git.sh
#
# Settings for git. Additional settings can be found in the following
# locations:
#   - $HOME/.oh-my-zsh/plugins/git/git.plugin.zsh
#   - $HOME/.gitconfig
#   - $HOME/.gitconfig.local
#   - $HOME/.scm_breeze
#
###############################################################################

# gg is aliased to 'git gui citool' at the following location:
#
#   $HOME/.oh-my-zsh/plugins/git/git.plugin.zsh#105
#
# However, in order to use the gg command line tool (installed via
# node-packages), this alias must be unset.
#
# Also, redirect errors to /dev/null if it's not set, as is currently the case
# in the bash side of this configuration.
unalias gg 2>/dev/null
