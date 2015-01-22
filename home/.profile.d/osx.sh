#==============================================================================
# A collection of OS X shell functions / aliases
#==============================================================================

# Airport ---------------------------------------------------------------------

# Show current airport status.
apinfo() {
  /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport --getinfo
}

# Audio -----------------------------------------------------------------------

# Set the audio volume to a cetain level or mute.
volume() {
  case "$1" in
    mute)
      osascript -e "set volume output muted true"
      ;;
    [0-9])
      osascript -e "set volume $1"
      ;;
    *)
      printf "Usage: audio volume ( <0-9> | <mute> )\n"
      ;;
  esac
}

# Automator -------------------------------------------------------------------

mergepdf() {
  _usage="Usage: mergepdf -o output.pdf input{1,2,3}.pdf"
  if [ $# -eq 0 ]; then
    printf "%s\n" "$_usage"
    return 0
  fi
  case "$1" in
    -h|--help)
      printf "%s\n" "$_usage"
      ;;
    *)
      /System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py "$@"
      ;;
  esac
}


# Clipboard -------------------------------------------------------------------

# Copy the current pwd (working directory) to the clipboard.
cpwd() {
  pwd | xargs echo -n | pbcopy
}

# Trim new lines and copy to clipboard
clean_copy() {
  tr -d '\n' | pbcopy
}

# Desktop ---------------------------------------------------------------------

# Hide/show all desktop icons (useful when presenting)
desktop() {
  _usage="Usage: desktop icons ( hide | show )"
  test "$1" != "icons" && printf "%s\n" "$_usage" && return 0
  shift
  case "$1" in
    hide)
      defaults write com.apple.finder CreateDesktop -bool false && \
        killall Finder
      ;;
    show)
      defaults write com.apple.finder CreateDesktop -bool true && \
        killall Finder
      ;;
    *)
      printf "%s\n" "$_usage"
      ;;
  esac
}

# DNS -------------------------------------------------------------------------

# Flush Directory Service cache
dnsflush() {
  dscacheutil -flushcache && killall -HUP mDNSResponder
}
# Alias to avoid dyslexia
flushdns() {
  dnsflush
}

# Finder ----------------------------------------------------------------------

# Hide/show hidden files in Finder
finder() {
  _usage="Usage: finder hidden ( hide | show )"
  test "$1" != "hidden" && printf "%s\n" "$_usage" && return 1
  shift
  case "$1" in
    hide)
      defaults write com.apple.finder AppleShowAllFiles -bool false && \
        killall Finder
      ;;
    show)
      defaults write com.apple.finder AppleShowAllFiles -bool true && \
        killall Finder
      ;;
    *)
      printf "%s\n" "$_usage"
      ;;
  esac
}

# Recursively delete `.DS_Store` files
clean_ds_store() {
  find . -type f -name '*.DS_Store' -ls -delete
}

# hdiutil ---------------------------------------------------------------------

# Ejects a given disk image.
eject() {
  hdiutil eject "$*"
}

# JavaScript ------------------------------------------------------------------

jsc() {
  _jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc"
  if [ -e "$_jscbin" ]; then
    "$_jscbin" "$*"
  else
    printf "JavaScriptCore.framework not found.\n"
  fi
}

# LaunchServices --------------------------------------------------------------

# Clean up LaunchServices to remove duplicates in the “Open With” menu
lscleanup() {
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder
}

# Locate ----------------------------------------------------------------------

# Update the locate database.
updatedb() {
  sudo /usr/libexec/locate.updatedb
}

# Preferences -----------------------------------------------------------------

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
plistbuddy() {
  /usr/libexec/PlistBuddy "$@"
}


# Quick Look ------------------------------------------------------------------

# Open items with Quick Look.
ql() {
  qlmanage -p "$*" 2>/dev/null
}

# Security --------------------------------------------------------------------

# Lock the screen (when going AFK)
afk() {
  "/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession" -suspend
}

# Shell -----------------------------------------------------------------------

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Spotlight -------------------------------------------------------------------

# Spotlight searching and controls.
#
# Usage:
#   spotlight find      <filename>
#   spotlight filename  <filename>
#   spotlight content   <text>
#   spotlight disable
#   spotlight enable
spotlight() {
  case "$1" in
    filename|find)
      shift
      mdfind "kMDItemDisplayName == '$*'wc"
      ;;
    content)
      shift
      mdfind -interpret "$*"
      ;;
    disable)
      sudo mdutil -a -i off
      ;;
    enable)
      sudo mdutil -a -i on
      ;;
    *|-h|--help)
      printf "\
Usage:
  spotlight find      <filename>
  spotlight filename  <filename>
  spotlight content   <text>
  spotlight disable
  spotlight enable
"
      ;;
  esac
}

# Trash -----------------------------------------------------------------------

# Empty the Trash on all mounted volumes and the main HDD
emptytrash() {
  sudo rm -rfv /Volumes/*/.Trashes
  sudo rm -rfv ~/.Trash
}

# Updates ---------------------------------------------------------------------

update_apps() {
  softwareupdate -i -a
}
