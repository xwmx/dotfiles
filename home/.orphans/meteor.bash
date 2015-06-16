desc "meteor:up" <<EOM
Usage:
  $_ME meteor:up

Description:
  Meteor is an ultra-simple environment for building modern web applications.

  With Meteor you write apps:
  - in pure JavaScript
  - that send data over the wire, rather than HTML
  - using your choice of popular open-source libraries
  - Documentation is available at http://docs.meteor.com/

  https://www.meteor.com/
  https://github.com/meteor/meteor
  https://install.meteor.com/
EOM
meteor:up() {
  if [[ -f "/usr/local/bin/meteor" ]]
  then
    printf "meteor is already installed.\n" && exit 0
  fi
  printf ">> Installing meteor\n"
  curl https://install.meteor.com | /bin/sh
}

desc "meteor:down" <<EOM
Usage:
  $_ME meteor:down

Description:
  Unisntall Meteor.
EOM
meteor:down() {
  printf ">> Uninstalling meteor\n"
  [[ -e "$HOME/.meteor/"        ]] && _remove "$HOME/.meteor/"
  [[ -e "/usr/local/bin/meteor" ]] && _remove "/usr/local/bin/meteor"
}
