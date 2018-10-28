###############################################################################
# VVV - Varying Vagrant Vagrants
#
# Shell settings for vvv
#
# https://github.com/Varying-Vagrant-Vagrants/VVV
###############################################################################


# .bash_profile settings.
#
# Adapted from the generated .bash_profile in vagrant@vvv account.
if [[ "$(hostname)" == "vvv" ]]
then
  # Set the WP_TESTS_DIR path directory so that we can use phpunit inside
  # plugins almost immediately.
  export WP_TESTS_DIR=/srv/www/wordpress-develop/tests/phpunit/
  # Set the WP_CORE_DIR path so phpunit tests are run against WP trunk
  export WP_CORE_DIR=/srv/www/wordpress-develop/src/

  if is_bash
  then
    # add autocomplete for grunt
    eval "$(grunt --completion=bash)"

    # add autocomplete for wp-cli
    . /srv/www/wp-cli/utils/wp-completion.bash
  fi

  # PHPCS path
  export PATH="$PATH:/srv/www/phpcs/scripts/"

  # nvm path
  export NVM_DIR="/srv/config/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
fi
