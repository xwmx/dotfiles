# .bashrc
#
# More info about OS X shell startup:
# http://hayne.net/MacDev/Notes/unixFAQ.html#shellStartup
#
# PATH --------------------------------------------------------------------
# Note: Additional PATH initialization in /etc/paths and /etc/paths.d


# Where the magic happens.
export DOTFILES=~/.dot

# Add binaries into the path
PATH=$DOTFILES/bin:$PATH
export PATH

#==========================================================================
# Utility Functions
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
  if ! program_exists not_a_real_program; then
    echo "test_program_exists Failed"
  fi
  if program_exists bash; then
    echo "test_program_exists Failed"
  fi

}

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
# Shell prompt settings.
# default: host:~ user$
# colors denoted with \[\033[Xm\] where X is the color's number
#==========================================================================

##################################
# a function to get a git branch for display in the prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
##################################

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}


##################################
# Display the working directory in the prompt, truncated with a leading "..."
# when it reaches the character limit. Preseve ~ when in home directory.
# host:~/dirname user$ if ab_path_minus_Users/username < char limit
# host:up_to_23_chars_of_ab_path_minus_Users/username user$ if > char limit
# without color: '\h:\w \u$ '
# http://tldp.org/HOWTO/Bash-Prompt-HOWTO/
##################################

function prompt_command () {
    #   How many characters of the $PWD should be kept
    local pwd_length=23
      if [ $(echo -n $PWD | wc -c | tr -d " ") -gt $pwd_length ]; then
      if [ $(echo -n $PWD | egrep -o /Users/$(id -un) | wc -c | tr -d " ") -gt 0 ]; then
        local user_length=$(echo -n $PWD | egrep -o /Users/$(id -un) | wc -c | tr -d " ");
        local total_length=$(echo -n $PWD | wc -c | tr -d " ");
        let "newPwd_length=$total_length-$user_length";

        if [ $newPwd_length -gt $pwd_length ]; then
          # when in home and path minus users/username is longer than char limit
          newPWD="$(echo -n $PWD | sed -e "s/.*\(.\{$pwd_length\}\)/\1/")";export PS1='\[\033[45;30m\] \[\033[0;7;34m\]\u\[\033[0;0;32m\]@\[\033[0;0;34m\][\h]:\[\033[0;0;37m\]~\[\033[0;4;31m\]...\[\033[0;0;37m\]$newPWD $(vcprompt)\[\033[0;0;32m\]$\[\033[0m\] '
        else
          # when in home and path minus users/username is less than limit
          newPWD="$(echo -n $PWD | sed -e "s/.*\(.\{$newPwd_length\}\)/\1/")";export PS1='\[\033[45;30m\] \[\033[0;7;34m\]\u\[\033[0;0;32m\]@\[\033[0;0;34m\][\h]:\[\033[0;0;37m\]~/$newPWD $(vcprompt)\[\033[0;0;32m\]$\[\033[0m\] '
        fi
      else
        # when not in home and path is longer than char limit
        newPWD="$(echo -n $PWD | sed -e "s/.*\(.\{$pwd_length\}\)/\1/")";export PS1='\[\033[45;30m\] \[\033[0;7;34m\]\u\[\033[0;0;32m\]@\[\033[0;0;34m\][\h]:\[\033[0;4;31m\]...\[\033[0;0;37m\]$newPWD $(vcprompt)\[\033[0;0;32m\]$\[\033[0m\] '
      fi
    # when not in home and path is shorter than char limit
    else export PS1='\[\033[45;30m\] \[\033[0;7;34m\]\u\[\033[0;0;32m\]@\[\033[0;0;34m\][\h]:\[\033[0;0;37m\]\w $(vcprompt)\[\033[0;0;32m\]$\[\033[0m\] '
  fi
}
PROMPT_COMMAND=prompt_command
export PROMPT_COMMAND

##################################
# UNUSED - above is derived from this
# host:absolute_path user$ if < 23 chars
# host:23_chars_of_absolute_path user$ if > 23 chars
##################################

<<\COMMENT
function prompt_command {
     #   How many characters of the $PWD should be kept
     local pwd_length=23
     if [ $(echo -n $PWD | wc -c | tr -d " ") -gt $pwd_length ]
         then newPWD="$(echo -n $PWD | sed -e "s/.*\(.\{$pwd_length\}\)/\1/")"
         else newPWD="echo -n $PWD"
     fi
}
PROMPT_COMMAND=prompt_command
export PROMPT_COMMAND
#export PS1='\h:$newPWD \u$ '
export PS1=$newPWD
COMMENT


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
# ls
#==========================================================================


alias ls="ls -GF"
alias la='ls -laGFh'
alias lal='ls -laGFh | less -R'
alias ll='ls -alF'


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
# Other aliases
#==========================================================================

# Prevent accidentally killing files
#alias rm='rm -i'
#alias cp='cp -i'
#alias mv='mv -i'

# Create intermediate directories as required
alias mkdir='mkdir -p'

alias l='ls -la'

#==========================================================================
# locate
#==========================================================================

# update locate database
alias updatedb='sudo /usr/libexec/locate.updatedb'

#==========================================================================
# Here are a variety of aliases for OS X specific stuff
#==========================================================================

alias trash="cd ~/.trash"
alias home="cd ~/"
alias desktop="cd ~/desktop"
alias textedit="open /applications/textedit.app"
alias sysprefs="open /applications/utilities/systempreferences.app"
alias actmon="open /applications/utilities/activity\ monitor.app"
alias x11="open /applications/utilities/x11.app"

# eject a volume
alias eject='hdiutil eject'
# copy the working dir to the clipboard
alias cpwd='pwd|xargs echo -n|pbcopy'
# current airport status
alias apinfo='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I'
# use spotlight to search for a file
spotlightfile() {
    mdfind "kMDItemDisplayName == '$@'wc";
}
#use spotlight to search file contents:
spotlightcontent() {
  mdfind -interpret "$@";
}

#==========================================================================
# Git
#==========================================================================

alias g='git'
alias gb='git branch'
alias gba='git branch -a'
alias gstat='git status'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gd='git diff | mate'
alias gl='git pull'
alias gp='git push'
alias glog="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(magenta)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

# Alias the `git` command to the `hub` command.
# http://github.com/defunkt/hub
alias git=hub

#==========================================================================
# Rails aliases
#==========================================================================
alias sc='script/console'
alias ss='script/server'
alias ss80='sudo script/server -p 80'
alias remigrate='rake db:remigrate && rake db:test:clone'
alias atst='autotest'

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

if [[ -s /Users/automat/.rvm/scripts/rvm ]] ; then
  source /Users/automat/.rvm/scripts/rvm ;
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

#==========================================================================
# misc
#==========================================================================

# Search commandline fu for snippits matching the input.
#
# Usage:
# $ cmdfu du
cmdfu(){
  curl "http://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext";
}

# Open the default web browser and search google
#
# Usage:
# $ google search these terms
google() {
  python -c "import sys, webbrowser, urllib;   webbrowser.open('http://www.google.com/search?' + urllib.urlencode({'q': ' '.join(sys.argv[1:]) }))" $@
}

# Prints the top 10 subdirectories by disk uage.
#
# http://oreilly.com/pub/h/15
#
# Usage:
# $ ducks
alias ducks='du -cks * |sort -rn |head -11'

# Print a UTC timestamp
#
# Usage:
# $ utc_timestamp
alias utc_timestamp='date -u "+%Y%m%d%H%M%S"'
alias utcts='utc_timestamp'

