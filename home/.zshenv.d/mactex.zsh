###############################################################################
# MacTex
#
# http://www.tug.org/mactex/
###############################################################################

# via Homebrew formula caveat:
#
# To use mactex, zsh users may need to add the following line to their
# ~/.zprofile.  (Among other effects, /usr/texbin will be added to the
# PATH environment variable): eval `/usr/libexec/path_helper -s`
if is_osx
then
  eval `/usr/libexec/path_helper -s`
fi
