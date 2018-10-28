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

###############################################################################
# Lazy load nvm.
#
# nvm loading is slow, so defer loading until one of the node functions is
# called.

# $__NVM_ENABLED
#
# 1  If nvm has been initialized.
# 0  If not.
export __NVM_ENABLED=0

# __enable_nvm()
#
# Usage:
#   __enable_nvm
#
# Description:
#   Initialize nvm.
__enable_nvm() {
  if ((__NVM_ENABLED)) || [[ -n "${NVM_DIR:-}" ]]
  then
    : # Do nothing, since NVM is already initialized.
  else
    __readlink_command="readlink"
    if hash "greadlink" 2>/dev/null
    then
      __readlink_command="greadlink"
    fi

    export NVM_DIR
    NVM_DIR="$("${__readlink_command}" -f "${HOME}/.nvm")"

    . "${NVM_DIR}/nvm.sh"
    __NVM_ENABLED=1
  fi
}

# __enable_nvm_lazy_loading()
#
# Usage:
#   __enable_nvm_lazy_loading
#
# Description:
#  Load nvm when a node-installed command is run.
#
# More Information:
# http://broken-by.me/lazy-load-nvm/
# https://gist.github.com/fl0w/07ce79bd44788f647deab307c94d6922
__enable_nvm_lazy_loading() {
  if [[ -e "${HOME}/.nvm" ]]
  then # nvm is installed
    declare -a __nvm_node_commands=($(
      find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' \
        | xargs -n1 basename \
        | sort \
        | uniq
    ))

    __nvm_node_commands+=("node")
    __nvm_node_commands+=("nvm")

    for __command_name in ${__nvm_node_commands[@]}
    do
      source /dev/stdin <<HEREDOC
${__command_name}() {
  unset -f ${__command_name}
  if [[ "${__NVM_ENABLED}" == 0 ]]
  then
    __enable_nvm
  fi
  ${__command_name} "\$@"
}
HEREDOC
    done
  fi
}

# Only load immediately if this is a child of a vim process.
if [[ -n "${VIMRUNTIME:-}" ]]
then
  __enable_nvm
else
  __enable_nvm_lazy_loading
fi
