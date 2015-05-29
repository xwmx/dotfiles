###############################################################################
# OPAM / OCaml env configuration
#
# The settings here are the output of the `opam config env` command, with some
# slight edits, specifically splitting them up to invidisual lines and using
# `$HOME` for the home path segment rather than the hard-coded home directory.
###############################################################################

CAML_LD_LIBRARY_PATH="$HOME/.opam/system/lib/stublibs:/usr/local/lib/ocaml/stublibs"
export CAML_LD_LIBRARY_PATH

OPAMUTF8MSGS="1"
export OPAMUTF8MSGS

MANPATH="$MANPATH:$HOME/.opam/system/man"
export MANPATH

PERL5LIB="$HOME/.opam/system/lib/perl5:$PERL5LIB"
export PERL5LIB

OCAML_TOPLEVEL_PATH="$HOME/.opam/system/lib/toplevel"
export OCAML_TOPLEVEL_PATH

PATH="$HOME/.opam/system/bin:$PATH"
export PATH
