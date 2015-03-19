###############################################################################
# Build / Configure Environment Variables
###############################################################################

if is_osx; then
  export ARCHFLAGS='-arch x86_64'
  export CFLAGS='-arch x86_64'
  # NOTE: LDFLAGS set to '-arch x86_64' causes build failures when installing
  # OPAM packages, and therefore this needs to be unset in
  # script/install/opam-packages
  export LDFLAGS='-arch x86_64'
fi
