# .hyperlocal

Program and data hierarchy for user-installed programs.

The `$HOME/.hyperlocal` hierarchy mirrors the `/usr/local` hierarchy, but
only applies to the current user. Installing programs to this location
avoids polluting `$HOME`. `$HOME/.local` would have been a logical
name, but this directory is used by GNOME and Ubuntu for application
data, so using this separate directory avoids unexpected conflicts.

Install programs to this location with `$PREFIX="$HOME/.hyperlocal"` or
`--prefix="$HOME/.hyperlocal"`.

This is used in a similar manner to the [`$HOME/.bpkg` hierarchy](../.bpkg).

Additional configuration files:
- [home/.shared_env.d/hyperlocal.sh](../.shared_env.d/hyperlocal.sh)
- [.gitignore](../../.gitignore)
