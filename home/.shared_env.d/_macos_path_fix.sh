###############################################################################
# _macos_path_fix.zsh
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
# why it has an underscore prefix.
#
# References:
#   http://www.zsh.org/mla/users/2015/msg00725.html
#   https://gist.github.com/zmwangx/290d617224f084bb0133
#   http://www.softec.lu/site/DevelopersCorner/MasteringThePathHelper
#   http://superuser.com/questions/482098/path-is-driving-me-nuts
#
# Other files:
#   $HOME/.zprofile.d/macos_path_fix.zsh
##############################################################################

if is_zsh && is_osx
then
  if is_el_capitan || is_sierra
  then
    # Call `path_helper`. Adapted from /etc/zprofile on OS X El Capitan.
    #
    # Note that if this isn't run, then /usr/local/bin isn't added to the $PATH.
    if [ -x /usr/libexec/path_helper ]
    then
      eval `/usr/libexec/path_helper -s`
    fi

    # Explicitly prepend another '/usr/local/bin' segment, which is used by
    # homebrew.
    #
    # The order is determined by '/etc/paths', which is ordered differently on
    # some of my systems. On a fresh OS X install, '/usr/local/bin' is the last
    # iterm in this file.
    PATH="/usr/local/bin:${PATH}"

    # NOTE: make sure `setopt global_rcs` is set in .zprofile or .zprofile.d.
    setopt no_global_rcs
  fi
fi
