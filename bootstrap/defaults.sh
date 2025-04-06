#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
    echo "Not macOS!"
    exit 1
fi

# Show bluetooth in the menu bar
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true

# Automatically hide or show the Dock
defaults write com.apple.dock autohide -bool true

# Show the full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool false

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool true

# Display battery level in the menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Display date, day, and time in the menu bar
defaults write com.apple.menuextra.clock DateFormat -string 'EEE d MMM HH:mm:ss'

# Increase keyboard initial delay
defaults write -g InitialKeyRepeat -int 15

# Increase keyboard repeat rate
defaults write -g KeyRepeat -int 2

# Show files with all extensions
defaults write -g AppleShowAllExtensions -bool false

for app in "Dock" \
    "Finder" \
    "SystemUIServer"; do
    killall "${app}" &> /dev/null
done