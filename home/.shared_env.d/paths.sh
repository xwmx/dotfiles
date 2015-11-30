###############################################################################
# paths.sh
#
# $PATH settings.
#
# Note: Additional $PATH initialization in /etc/paths and /etc/paths.d
###############################################################################

export PATH

# Add homebrew-managed /usr/local/sbin to $PATH
PATH="/usr/local/sbin:${PATH}"

# Add ~/.local/bin to $PATH
#
# `pip install` with the `--user` option installs executables in ~/.local/bin,
# at least on Ubuntu. ~/.local is part of the XDG Base Directory Specification.
#
# More info about ~/.local:
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# http://askubuntu.com/a/14536
PATH="${HOME}/.local/bin:${PATH}"
