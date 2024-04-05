#!bin/bash
# Things to do:
# - get git set up (ssh, username, email, etc)
# - install alacritty
# - install 1password
# - clone .config from github
git clone git@github.com:amikulka/.config.git ~/.config
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Install nerd-fonts
brew tap homebrew/cask-fonts
brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true
# Install starship for terminal prompt
brew install starship
# Install neovim
brew install neovim

