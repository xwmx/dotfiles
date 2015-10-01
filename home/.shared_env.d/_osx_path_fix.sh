###############################################################################
# _osx_path_fix.zsh
#
# OS X El Capitan moves the call to `path_helper`, "helper for constructing
# PATH environment variable," from /etc/zshenv to /usr/zprofile, which makes
# it run later in the initialization process. Because it runs after the
# contents of .shared_env.d/*, the $PATH entries are reordered such that the
# default global paths take precedence over any set within $HOME.
#
# In order to avoid this behavior, skip global rc file loading after *env
# files are loaded, then reenable in .zprofile, and run `path_helper` once
# before the files in .shared_env.
#
# NOTE: This file must be the first one that runs in .shared_env.d, which is
# whey it has an underscore prefix.
#
# References:
#   http://www.zsh.org/mla/users/2015/msg00725.html
#   https://gist.github.com/zmwangx/290d617224f084bb0133
#
# Other files:
#   $HOME/.zprofile.d/osx_path_fix.zsh
##############################################################################

if is_zsh && is_osx && is_el_capitan
then
  # Call `path_helper`. Adapted from /etc/zprofile on OS X El Capitan.
  #
  # Note that if this isn't run, then /usr/local/bin isn't added to the $PATH.
  if [ -x /usr/libexec/path_helper ]
  then
    eval `/usr/libexec/path_helper -s`
  fi

  setopt no_global_rcs
fi
