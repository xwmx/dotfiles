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
#

# _enable_scm_breeze()
#
# Usage:
#   _enable_scm_breeze
#
# Description:
#   Initialize SCM Breeze.
_enable_scm_breeze() {
  # NOTE: SCM Breeeze currently throws an error for me in bash.
  if ! is_bash
  then
    [ -s "${HOME}/.scm_breeze/scm_breeze.sh" ] && \
      source "${HOME}/.scm_breeze/scm_breeze.sh" 1>/dev/null
  fi
}

# git()
#
# A wrapper function to warn before initiating a `git push` to a production
# remote.
export ___ORIGINAL_GIT
___ORIGINAL_GIT=$(which git)
git() {
  # _this_is_probably_a_function_defintion()
  #
  # Usage:
  #   _this_is_probably_a_function_defintion <string>
  #
  # Returns:
  #   0  If the string is probably a function defintion.
  #   1  If not.
  _this_is_probably_a_function_defintion() {
    # Assume that it's a function if it contains newlines, since a path
    # wouldn't.
    #
    # NOTE: This is the only semi-portable way to define a newline that I've
    # been able to find so far.
    local _newline="
"
    [[ "${1:-}" =~ ${_newline} ]]
  }

  if [[ "${1:-}" == "push" ]] && [[ "${2:-}" == "production" ]]
  then
    while true
    do
      printf "🚀 'git push' to 'production'? [y/N] "
      read -r yn
      case ${yn} in
        [Yy]*)
          if _this_is_probably_a_function_defintion "${___ORIGINAL_GIT}"
          then
            # Run in subshell to avoid global `git()` function override.
            (
              eval "${___ORIGINAL_GIT}"
              git "$@"
            )
          else
            "${___ORIGINAL_GIT}" "$@"
          fi
          break
          ;;
        *)
          printf "🛬 'git push' cancelled.\n"
          break
          ;;
      esac
    done
  else
    if _this_is_probably_a_function_defintion "${___ORIGINAL_GIT}"
    then
      # Run in subshell to avoid global `git()` function override.
      (
        eval "${___ORIGINAL_GIT}"
        git "$@"
      )
    else
      "${___ORIGINAL_GIT}" "$@"
    fi
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
