desc "exa:up" <<EOM
Usage:
  $_ME exa:up

Description:
  \`exa\` is a modern replacement for ls. It uses colours for information by
  default, helping you distinguish between many types of files, such as whether
  you are the owner, or in the owning group. It also has extra features not
  present in the original ls, such as viewing the Git status for a directory,
  or recursing into directories with a tree view. \`exa\` is written in Rust,
  so it's small, fast, and portable.

  http://bsago.me/exa/

  NOTE: included as an orhan because a rust crate doesn't appear to exist for
  it yet and, therefore, it needs to be built with cargo.
EOM
exa:up() {
  # Don't install if exa is already installed.
  if [[ -f "$HOME/bin/exa" ]]
  then
    printf "exa already installed.\n" && exit 0
  fi
  # Make sure cmake is installed
  if [[ ! -f "$(which cmake)" ]]
  then
    printf "Install cmake dependency.\n" && exit 0
  fi
  # Make sure libgit2 is installed.
  if ! _is_installed_with_homebrew "libgit2"
  then
    printf "Install libgit2 dependency.\n" && exit 0
  fi

  printf ">> Installing exa\n"

  local tmp_repo=/tmp/orphans/exa
  local remote_url=https://github.com/ogham/exa.git

  export PREFIX="$HOME"
  git clone "$remote_url" "$tmp_repo" &&
    cd "$tmp_repo" &&
    make install &&
    cd "/tmp/orphans" &&
    _remove "$tmp_repo"
  unset PREFIX
}

desc "exa:down" <<EOM
Usage:
  $_ME exa:down

Description:
  Uninstall exa.
EOM
exa:down() {
  printf ">> Uninstalling exa\n"
  [[ -e "$HOME/bin/exa"    ]] && _remove "$HOME/bin/exa"
  [[ -e "/tmp/orphans/exa" ]] && _remove "/tmp/orphans/exa"
}
