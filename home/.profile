#==========================================================================
# Utility Functions
#
# Note: these functions must be included prior to the .profile.d or .bashrc.d
# files that use them.
#==========================================================================

# OS detection
function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}
function get_os() {
  for os in osx ubuntu; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}

# Check whether a program exists in the PATH
#
# For information on why `which` is not being used, see:
# http://stackoverflow.com/a/677212
program_exists() {
  hash $1 2>/dev/null
}

test_program_exists() {
  if ! program_exists not_a_real_program ; then
    echo "test_program_exists Passed"
  fi
  if program_exists bash ; then
    echo "test_program_exists Passed"
  fi

}

# source all files in a directory, or optionally source one file from a
# specified directory.
function init_src() {
  local file
  if [ -n "$2" ]; then
    source "$HOME/$1/$2"
  elif [ -n "$1" ]; then
    for file in $HOME/$1/*; do
      source "$file"
    done
  else
    echo "Please specify directory to be sourced."
    return 1
  fi
}


#==========================================================================
# Init
#==========================================================================

# Source all files in ".profile.d"
init_src .profile.d

