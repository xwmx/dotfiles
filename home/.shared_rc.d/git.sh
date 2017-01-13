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

# Load scm_breeze.
#
# This line would have been added to the rc files by the
# $HOME/.scm_breeze/install.sh script.
#
# Additionally, 1>/dev/null silences the following message:
#   SCM Breeze must be loaded after RVM...
#
# The SCM Breeze installation can be found
# at $HOME/.scm_breeze
#
# https://github.com/ndbroadbent/scm_breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && \
  source "$HOME/.scm_breeze/scm_breeze.sh" 1>/dev/null

# git()
#
# A wrapper function to warn before initiating a `git push` to a production
# remote.
export ___SCMB_GIT_FUNCTION
___SCMB_GIT_FUNCTION=$(which git)
git() {
  if [[ "${1:-}" == "push" ]] && [[ "${2:-}" == "production" ]]
  then
    while true
    do
      printf "🚀 'git push' to 'production'? [y/N] "; read -r yn
      case ${yn} in
        [Yy]*)
          # Run in subshell to avoid global `git()` function override.
          (
            eval "${___SCMB_GIT_FUNCTION}"
            git "${@}"
          )
          break
          ;;
        *)
          printf "🛬 'git push' cancelled.\n"
          break
          ;;
      esac
    done
  else
    # Run in subshell to avoid global `git()` function override.
    (
      eval "${___SCMB_GIT_FUNCTION}"
      git "${@}"
    )
  fi
}

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
