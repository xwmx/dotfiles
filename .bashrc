source ~/.bash_profile
# rvm-install added line:
if [[ -s /Users/automat/.rvm/scripts/rvm ]] ; then source /Users/automat/.rvm/scripts/rvm ; fi


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
