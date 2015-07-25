###############################################################################
# fasd
#
# Command-line productivity booster, offers quick access to files and
# directories, inspired by autojump, z and v.
#
# NOTE: installed via homebrew.
#
# https://github.com/clvv/fasd
###############################################################################

# Initialize all.
#
# This will setup a command hook that executes on every command and advanced
# tab completion for zsh and bash.
#
# For more specific initialization options, see:
# https://github.com/clvv/fasd#install
if program_exists "fasd"
then
  eval "$(fasd --init auto)"
fi
