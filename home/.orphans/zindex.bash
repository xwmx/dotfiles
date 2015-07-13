export PREFIX="$HOME/.hyperlocal"

desc "zindex:up" <<EOM
Usage:
  $_ME zindex:up

Description:
  Create an index on a compressed text file

  zindex creates and queries an index on a compressed, line-based text file in
  a time- and space-efficient way.

  https://github.com/mattgodbolt/zindex
EOM
zindex:up() {
  # Don't install if already installed.
  if [[ -f "$PREFIX/bin/zindex" ]]
  then
    printf "zindex (zindex) already installed.\n" && exit 0
  fi
  if [[ -f "$PREFIX/bin/zq" ]]
  then
    printf "zindex (zq) already installed.\n" && exit 0
  fi

  # Remove if installed in old location.
  # TODO: remove these lines.
  [[ -e "$HOME/bin/zq"        ]] && _remove "$HOME/bin/zq"
  [[ -e "$HOME/bin/zindex"    ]] && _remove "$HOME/bin/zindex"

  local tmp_repo=/tmp/orphans/zindex
  local remote_url=https://github.com/mattgodbolt/zindex.git

  git clone "$remote_url" "$tmp_repo" &&
    cd "$tmp_repo" &&
    make &&
    [[ ! -d "$PREFIX/bin" ]] && mkdir -p "$PREFIX/bin" || true &&
    cp "$tmp_repo/build/Release/zindex" "$PREFIX/bin" &&
    cp "$tmp_repo/build/Release/zq" "$PREFIX/bin" &&
    cd "/tmp/orphans" &&
    _remove "$tmp_repo"
}

desc "zindex:down" <<EOM
Usage:
  $_ME zindex:down

Description:
  Uninstall zindex.
EOM
zindex:down() {
  printf ">> Uninstalling zindex\n"

  # Remove if installed in old location.
  # TODO: remove these lines.
  [[ -e "$HOME/bin/zq"        ]] && _remove "$HOME/bin/zq"
  [[ -e "$HOME/bin/zindex"    ]] && _remove "$HOME/bin/zindex"

  local tmp_location="/tmp/orphans/zindex"
  [[ -e "$tmp_location"       ]] && _remove "$tmp_location"
  [[ -e "$PREFIX/bin/zq"      ]] && _remove "$PREFIX/bin/zq"
  [[ -e "$PREFIX/bin/zindex"  ]] && _remove "$PREFIX/bin/zindex"
}
