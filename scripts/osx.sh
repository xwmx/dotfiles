# Disk Utility

# Enable the debug menu. Reset command:
# $ defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool false
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true

# Enable advanced options
# TODO: this was already set to `"advanced-image-options" = 1`, so the actual
# default will need to be determined.
defaults write com.apple.DiskUtility advanced-image-options -bool true
