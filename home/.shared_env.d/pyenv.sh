###############################################################################
# pyenv
#
# Simple Python version management
#
# pyenv lets you easily switch between multiple versions of Python. It's
# simple, unobtrusive, and follows the UNIX tradition of single-purpose tools
# that do one thing well.
#
# This project was forked from rbenv and ruby-build, and modified for Python.
#
# https://github.com/yyuu/pyenv
#
# pyenv plugins:
# - https://github.com/yyuu/pyenv-doctor
# - https://github.com/yyuu/pyenv-installer
# - https://github.com/yyuu/pyenv-update
# - https://github.com/yyuu/pyenv-virtualenv
# - https://github.com/yyuu/pyenv-which-ext
###############################################################################

# _enable_pyenv()
#
# Usage:
#   _enable_pyenv
#
# Description:
#   Initialize pyenv and $PATH for bin directory.
_enable_pyenv() {
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:${PATH}"

  # Exit if `pyenv` not found.
  if ! which pyenv > /dev/null
  then
    return 0
  fi

  # Exit if `brew` not found.
  if ! which brew > /dev/null
  then
    return 0
  fi

  eval "$(pyenv init -)"

  # Set `$CFLAGS` and `$LDFLAGS`
  #
  # Fix for pyenv-doctor build failure with the following message:
  # 'configure: error: OpenSSL development header is not installed.'
  #
  # https://github.com/yyuu/pyenv/wiki/Common-build-problems
  #
  # NOTE: Do not include a space between the `-I` or `-L` option and value.
  export CFLAGS
  export LDFLAGS
  CFLAGS="${CFLAGS} -I$(brew --prefix openssl)/include"
  LDFLAGS="${LDFLAGS} -L$(brew --prefix openssl)/lib"

  # https://github.com/yyuu/pyenv-virtualenv
  eval "$(pyenv virtualenv-init -)"
}

export __PYENV_ENABLED=0

python() {
  unset -f python
  if hash "__enable_pyenv" 2>/dev/null
  then
    __enable_pyenv
    __PYENV_ENABLED=1
  fi
  python "$@"
}
