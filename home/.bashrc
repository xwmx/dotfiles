# .bashrc
#
# More info about OS X shell startup:
# http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup
#
# PATH --------------------------------------------------------------------
# Note: Additional PATH initialization in /etc/paths and /etc/paths.d


source $HOME/.profile

#==========================================================================
# Init
#==========================================================================

# Source all files in ".bashrc.d"
init_src .bashrc.d

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
# Terminal color
#==========================================================================

export CLICOLOR=1
export TERM='xterm-color'
# export "TERM=linux"
# export CLICOLOR_FORCE=true


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
# Java / JVM
#==========================================================================

export JAVA_HOME=$(/usr/libexec/java_home)
export SCALA_HOME="/usr/local/Cellar/scala/2.7.7"
export JAVA="$JAVA_HOME/bin/java"
export SCALA="$SCALA_HOME/bin/scala"
export MYSQL_CONNECTOR_JAR="/Library/Java/Extensions/mysql-connector.jar"

#==========================================================================
# RVM
#==========================================================================

if [[ -s $HOME/.rvm/scripts/rvm ]] ; then
  source $HOME/.rvm/scripts/rvm ;
fi
