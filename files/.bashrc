# .bashrc
#
# More info about OS X shell startup:
# http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup
#
# PATH --------------------------------------------------------------------
# Note: Additional PATH initialization in /etc/paths and /etc/paths.d

#==========================================================================
# Utility Functions
#
# Note: these functions must be included prior to the .bashrc.d files that
# use them.
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
  if program_exists not_a_real_program; then
    echo "test_program_exists Failed"
  fi
  if ! program_exists bash; then
    echo "test_program_exists Failed"
  fi

}

#==========================================================================
# Init
#==========================================================================

# Set DOTFILES directory
export DOTFILES=~/.dot

# Add binaries into the path
PATH=$DOTFILES/bin:$PATH
export PATH

# Source all files in ".bashrc.d"
function src() {
  local file
  if [[ "$1" ]]; then
    source "$HOME/.bashrc.d/$1"
  else
    for file in $HOME/.bashrc.d/*; do
      source "$file"
    done
  fi
}

src

#==========================================================================
# PATH
#==========================================================================

# Path to homebrew-installed GNU core utilities, the 'coreutils' package
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

#==========================================================================
# Build / Configure Environment Variables
#==========================================================================

if is_osx; then
  export ARCHFLAGS='-arch x86_64'
  export CFLAGS='-arch x86_64'
  export LDFLAGS='-arch x86_64'
fi

#==========================================================================
# Locale
#
# These are also mostly set in Terminal.app preferences, at:
# Profiles > Advanced > Set locale environment variables on startup
#==========================================================================

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8

#==========================================================================
# History controls
#==========================================================================

# Entries beginning with space aren't added into history, and duplicate
# entries will be erased (leaving the most recent entry).
export HISTCONTROL="ignoreboth"
# Give history timestamps.
export HISTTIMEFORMAT="[%F %T] "
# Lots o' history.
export HISTSIZE=10000
export HISTFILESIZE=10000

#==========================================================================
# Editor
#==========================================================================

export EDITOR=mvim

#==========================================================================
# Vim
#==========================================================================

# Directory containing MacVim.app
export VIM_APP_DIR="/Applications"

#==========================================================================
# Amazon keys
#==========================================================================

if [[ -f "$HOME/.amazon_keys" ]]; then
    source "$HOME/.amazon_keys";
fi

#==========================================================================
# App Passwords
#==========================================================================

if [[ -f "$HOME/.app_passwords" ]]; then
    source "$HOME/.app_passwords";
fi

#==========================================================================
# Terminal color
#==========================================================================

export CLICOLOR=1
export TERM='xterm-color'
# export "TERM=linux"
# export CLICOLOR_FORCE=true


#==========================================================================
# Grep
#==========================================================================

# Use color by default
if echo hello|grep --color=auto l >/dev/null 2>&1; then
  export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
fi

#==========================================================================
# Mategem
#==========================================================================

# Extend mategem to add tab-completion
_mategem ()
{
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}
    local gems="$(gem environment gemdir)/gems"
    CLICOLOR=0
    if [ $COMP_CWORD -eq 1 ] || [ "${prev:0:1}" = "-" ]; then
        COMPREPLY=( $( compgen -W '$(ls $gems)' $cur ))
    else
        COMPREPLY=( $( compgen -f $cur ))
    fi
    return 0
}

complete -F _mategem -o dirnames mategem

#==========================================================================
# Ruby
#==========================================================================

# `ruby` on its own launches irb. Have `ruby` call `irb` when there is no
# argument.
ruby_or_irb () {
  if [ "$1" == "" ]; then
    irb
  else
    ruby "$@"
  fi
}
alias ruby="ruby_or_irb"

#==========================================================================
# Z
#
# Tracks your most used directories, based on 'frecency'.
#
# After  a  short  learning  phase, z will take you to the most 'frecent'
# directory that matches ALL of the regexes given on the command line, in
# order.
#
# For example, z foo bar would match /foo/bar but not /bar/foo.
#
# https://github.com/rupa/z/
#
# Expects installation via homebrew
#==========================================================================

if program_exists brew; then
  if [[ -f `brew --prefix`/etc/profile.d/z.sh ]]; then
    . `brew --prefix`/etc/profile.d/z.sh;
  fi
fi

#==========================================================================
# Go
#==========================================================================

export GOROOT=/usr/local/go
export GOPATH=$HOME/.go
export PATH=$PATH:${GOPATH//://bin:}/bin

#==========================================================================
# RVM
#==========================================================================

if [[ -s $HOME/.rvm/scripts/rvm ]] ; then
  source $HOME/.rvm/scripts/rvm ;
fi

#==========================================================================
# Heroku
#==========================================================================

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"


#==========================================================================
# Postgres
#==========================================================================

# Add postgres binaries to PATH
export PATH=/Applications/Developer/Postgres.app/Contents/MacOS/bin:$PATH

#==========================================================================
# Java / JVM
#==========================================================================

export JAVA_HOME=$(/usr/libexec/java_home)
export SCALA_HOME="/usr/local/Cellar/scala/2.7.7"
export JAVA="$JAVA_HOME/bin/java"
export SCALA="$SCALA_HOME/bin/scala"
export MYSQL_CONNECTOR_JAR="/Library/Java/Extensions/mysql-connector.jar"
