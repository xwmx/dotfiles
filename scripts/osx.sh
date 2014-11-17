###############################################################################
# Disk Utility
###############################################################################

# Enable the debug menu. Revert command:
# $ defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool false
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true

# Enable advanced options
# TODO: this was already set to `"advanced-image-options" = 1`, so the actual
# default will need to be determined.
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Finder
###############################################################################

# Finder: allow text selection in Quick Look. Revert command:
# $ defaults delete com.apple.finder QLEnableTextSelection
defaults write com.apple.finder QLEnableTextSelection -bool true

###############################################################################
# Kill affected applications
###############################################################################

for app in "Disk Utility" "Finder"; do
	killall "${app}" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
