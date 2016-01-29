#!/usr/bin/env bash
# NOTE: zsh required. The bash shebang is only for shellcheck.
###############################################################################
# .zshrc.d/nocorrect.zsh
#
# More information:
# http://zsh.sourceforge.net/Intro/intro_16.html
# http://superuser.com/a/610025
###############################################################################

# Turn off spelling correction for arguments.
unsetopt correct_all

# Turn on spelling correction for commands.
setopt correct
