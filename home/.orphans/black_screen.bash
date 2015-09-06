_BLACK_SCREEN_TMP_PATH="/tmp/orphans/black_screen"

desc "black_screen:up" <<EOM
Usage:
  $_ME black_screen:up

Description:
  Black Screen is a modern terminal emulator based on Electron and exploiting
  capabilities of contemporary interfaces in contrast to most of the terminal
  emulators.

Homepage:
  https://github.com/shockone/black-screen
EOM
black_screen:up() {

  printf ">> Installing Black Screen\n"

  git clone --recursive \
    "https://github.com/shockone/black-screen.git" "${_BLACK_SCREEN_TMP_PATH}" &&
      cd "${_BLACK_SCREEN_TMP_PATH}" &&
      npm run install-all

  printf \
    ">> NOTE: Downloaded to %s but not installed." \
    "${_BLACK_SCREEN_TMP_PATH}"
}

desc "black_screen:down" <<EOM
Usage:
  $_ME black_screen:down

Description:
  Uninstall Black Screen
EOM
black_screen:down() {
  printf ">> Uninstalling Black Screen.\n"
  [[ -e "{_BLACK_SCREEN_TMP_PATH}" ]] && _remove "${_BLACK_SCREEN_TMP_PATH}"
}
