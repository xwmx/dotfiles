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
  if [[ -f "$HOME/bin/zindex" ]]
  then
    printf "zindex (zindex) already installed.\n" && exit 0
  fi
  if [[ -f "$HOME/bin/zq" ]]
  then
    printf "zindex (zq) already installed.\n" && exit 0
  fi

  local tmp_repo=/tmp/orphans/zindex
  local remote_url=https://github.com/mattgodbolt/zindex.git

  git clone "$remote_url" "$tmp_repo" &&
    cd "$tmp_repo" &&
    make &&
    cp "$tmp_repo/build/Release/zindex" "$HOME/bin" &&
    cp "$tmp_repo/build/Release/zq" "$HOME/bin" &&
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
  local tmp_location="/tmp/orphans/zindex"
  [[ -e "$tmp_location"       ]] && _remove "$tmp_location"
  [[ -e "$HOME/bin/zq"        ]] && _remove "$HOME/bin/zq"
  [[ -e "$HOME/bin/zindex"    ]] && _remove "$HOME/bin/zindex"
}
