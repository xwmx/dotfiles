source ~/.profile


# export DYLD_FALLBACK_LIBRARY_PATH=/usr/lib:/usr/local/lib
export PATH=/usr/local/share/python:/usr/local/mysql/bin:$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/local/bin:/opt/local/sbin:$HOME/.gem/ruby/1.8/bin:$HOME/.cabal/bin:$PATH
# Add Postgres.app binaries to PATH
export PATH=/Applications/Developer/Postgres.app/Contents/MacOS/bin:$PATH
# Add texbin to PATH
export PATH=/usr/texbin:$PATH




# not all rubies support this
# export RUBYOPT="rubygems"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#export LD_LIBRARY_PATH=/opt/local/lib:/usr/local/lib

export ARCHFLAGS='-arch x86_64'
export CFLAGS='-arch x86_64'
export LDFLAGS='-arch x86_64'

# export OS='darwin'


# To avoid issues with Lion and llvm

# export CC=/usr/bin/gcc-4.2

# # Setting PATH for MacPython 2.5
# # The orginal version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
# export PATH
#
# # Setting PATH for MacPython 2.6
# # The orginal version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"
# export PATH

#==========================================================================
# History controls. export HISTSIZE=500 is default.
#==========================================================================

export HISTSIZE=100
export HISTCONTROL=ignoreboth

#==========================================================================
# Use mvim as default editor
#==========================================================================

export EDITOR=$HOME/bin/mvim

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
# For textmate bundle checkouts
#==========================================================================

export LC_CTYPE=en_US.UTF-8

#==========================================================================
# Find Directory containing MacVim.app
#==========================================================================

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
# Make ls pretty
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
# Grep color
#==========================================================================

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
# update locate database
#==========================================================================

alias updatedb='sudo /usr/libexec/locate.updatedb'

#==========================================================================
# gcaldeamon
#==========================================================================

alias gcaldeamon_start='/Applications/Network/GCALDaemon/bin/standalone-start.sh'
alias gcaldeamon_sync='/Applications/Network/GCALDaemon/bin/sync-now.sh'

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
# Git aliases
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
# Extend mategem to add tab-completion
#==========================================================================

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
# gemedit completion
#==========================================================================

complete -C "/usr/bin/gemedit --complete" gemedit

#==========================================================================
# Ruby 1.9 sandbox
#==========================================================================

alias ruby19="export PATH=/opt/ruby19/bin:$PATH"
alias r19="ruby19"

#==========================================================================
# `ruby` on its own launches irb
#==========================================================================

ruby_or_irb () {
  if [ "$1" == "" ]; then
    irb
  else
    ruby "$@"
  fi
}
alias ruby="ruby_or_irb"

#==========================================================================
# Shoes
#==========================================================================

alias shoes="open -a Shoes.app"


alias mondod_start="mongod run --config /usr/local/Cellar/mongodb/1.4.0-x86_64/mongod.conf"

#==========================================================================
# emacs
#==========================================================================

alias emacs='open -a Emacs "$@"'

#==========================================================================
# j2
#==========================================================================

export JPY=$HOME/bin/j.py # tells j.sh where the python script is
. $HOME/bin/j.sh          # provides the j() function
source j.sh

alias jl='j -l'
alias jt='j -t recent'
alias jr='j -t rank'

#==========================================================================
# Go
#==========================================================================

export GOROOT=/usr/local/go
# export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/.go

export PATH=$PATH:${GOPATH//://bin:}/bin

#==========================================================================
# misc
#==========================================================================




# Memcached

EVENT_NOKQUEUE=yes

cmdfu(){ curl "http://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext"; }

# rvm-install added line:
if [[ -s /Users/automat/.rvm/scripts/rvm ]] ; then source /Users/automat/.rvm/scripts/rvm ; fi


# Java

export JAVA_HOME=$(/usr/libexec/java_home)
export SCALA_HOME="/usr/local/Cellar/scala/2.7.7"
export JAVA="$JAVA_HOME/bin/java"
export SCALA="$SCALA_HOME/bin/scala"
export MYSQL_CONNECTOR_JAR="/Library/Java/Extensions/mysql-connector.jar"

google() {
  python -c "import sys, webbrowser, urllib;   webbrowser.open('http://www.google.com/search?' + urllib.urlencode({'q': ' '.join(sys.argv[1:]) }))" $@
}


# http://oreilly.com/pub/h/15
alias ducks='du -cks * |sort -rn |head -11'


alias utc_timestamp='date -u "+%Y%m%d%H%M%S"'
alias utcts='utc_timestamp'
