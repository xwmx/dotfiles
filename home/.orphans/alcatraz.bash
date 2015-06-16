desc "alcatraz:up" <<EOM
Usage:
  $_ME alcatraz:up

Description:
  The package manager for Xcode.

  Alcatraz is an open-source package manager for Xcode. It lets you discover
  and install plugins, templates and color schemes without the need for
  manually cloning or copying files. It installs itself as a part of Xcode and
  it feels like home.

  http://alcatraz.io/
  https://github.com/supermarin/Alcatraz
EOM
alcatraz:up() {
  local _dev_shared_path
  local _install_location
  _dev_shared_path="${HOME}/Library/Application Support/Developer/Shared"
  _install_location="${_dev_shared_path}/Xcode/Plug-ins/Alcatraz.xcplugin"
  if [[ -e "$_install_location" ]]
  then
    printf "alcatraz is already installed.\n" && exit 0
  fi
  printf ">> Installing alcatraz\n"
  curl \
    -fsSL \
    https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh
}

desc "alcatraz:down" <<EOM
Usage:
  $_ME alcatraz:down [--remove-packages]

Options:
  --remove-packages  Remove packages

Description:
  Uninstall alcatraz.
EOM
alcatraz:down() {
  local _dev_shared_path
  local _install_location
  local _packages_path

  _dev_shared_path="${HOME}/Library/Application Support/Developer/Shared"
  _install_location="${_dev_shared_path}/Xcode/Plug-ins/Alcatraz.xcplugin"

  _packages_path="${HOME}/Library/Application Support/Alcatraz/"

  printf ">> Uninstalling alcatraz...\n"
  [[ -e "$_install_location" ]] && _remove "$_install_location"

  if _command_argv_includes "--remove-packages"
  then
  printf ">> Removing alcatraz packages...\n"
    [[ -e "$_packages_path" ]] && _remove "$_packages_path"
  fi
}
