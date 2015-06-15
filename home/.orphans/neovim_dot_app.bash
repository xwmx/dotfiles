desc "neovim_dot_app:up" <<EOM
Usage:
  $_ME neovim_dot_app:up

Description:
  OS X GUI for NeoVim.

  https://github.com/rogual/neovim-dot-app
EOM
neovim_dot_app:up() {
  local install_location="$HOME/Applications/NeoVim.app"

  if [[ -f "$install_location" ]]
  then
    printf "neovim-dot-app is already installed.\n" && exit 0
  fi

  printf ">> Installing neovim-dot-app\n"

  local tmp_repo=/tmp/orphans/neovim-dot-app
  local remote_url=https://github.com/rogual/neovim-dot-app.git

  git clone "$remote_url" "$tmp_repo" &&
    cd "$tmp_repo" &&
    make &&
    mv "${tmp_repo}/build/NeoVim.app" "$install_location" &&
    _remove "$tmp_repo"
}

desc "neovim_dot_app:down" <<EOM
Usage:
  $_ME neovim_dot_app:down

Description:
  Unisntall neovim-dot-app.
EOM
neovim_dot_app:down() {
  printf ">> Uninstalling neovim-dot-app\n"
  local install_location="$HOME/Applications/NeoVim.app"
  local tmp_location="/tmp/orphans/neovim-dot-app"
  [[ -e "$install_location" ]] && _remove "$install_location"
  [[ -e "$tmp_location" ]] && _remove "$tmp_location"
}
