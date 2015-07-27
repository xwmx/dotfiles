###############################################################################
# Linuxbrew
#
# Linuxbrew is a fork of Homebrew, the Mac OS package manager, for Linux.
#
# Features:
# - Can install software to a home directory and so does not require sudo
# - Install software not packaged by the native distribution
# - Install up-to-date versions of software when the native distribution is old
# - Use the same package manager to manage both your Mac and Linux machines
#
# http://brew.sh/linuxbrew/
# https://github.com/Homebrew/linuxbrew
###############################################################################

# Linuxbrew environment variables.
if is_linux
then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
  export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
fi
