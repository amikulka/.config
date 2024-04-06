#!/bin/bash
# Things to do:
# - get git set up (ssh, username, email, etc)
# - install alacritty
# - install 1password
# - clone .config from github
# git clone git@github.com:amikulka/.config.git ~/.config

# set up git aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

# create .zshrc
cd
ZSHRC=".zshrc"
touch $ZSHRC

# Using heredoc to assign multi-line string to a variable
read -r -d '' VAR <<'EOF'
export EDITOR="nvim"
export NVIM="nvim"

export STARSHIP_CONFIG=~/.config/alacritty/starship.toml

export CLI_COLOR=1
export LSCOLORS=exfxbxdxcxegedabagacad
export TMUX_CONF=~/.config/tmux/tmux.conf

alias ls="ls -G"
alias la="ls -laG"
alias ll="ls -lG"

alias vi=$NVIM

alias conf='cd ~/.config'

alias gpull='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gpo='git push origin $(git rev-parse --abbrev-ref HEAD)'

bindkey -s ^f "tmux-sessionizer\n"
EOF

echo "$VAR" >> $ZSHRC


# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#install latest node
brew install node

# install ripgrep
brew install ripgrep

# install jq
# jq is a lightweight and flexible command-line JSON processor
brew install jq

# Install 1password
brew install --cask 1password

# Install nerd-fonts
brew tap homebrew/cask-fonts
brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true

# Install starship for terminal prompt
brew install starship
echo 'eval "$(starship init zsh)"' >> $ZSHRC

# Install neovim
brew install neovim

# Install tmux
brew install tmux

# Install alacritty
brew install --cask alacritty

# Install sketchybar-app-font
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.16/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.20/icon_map_fn.sh -o ~/.config/sketchybar/plugins/icon_map_fn.sh

# Install sketchybar
brew tap FelixKratz/formulae
brew install sketchybar

# Install yabai
brew tap koekeishiya/formulae
brew install yabai

# Install skhd
brew install skhd

# Install Spotify
brew install --cask spotify
