#!/bin/sh

echo "Setting up for [31;1mDebian[0m"

# Build tools
sudo apt-get update
sudo apt-get install build-essential git
sudo apt-get install make cmake ninja-build clang gdb lldb
sudo apt-get install curl gettext

# Shell
sudo apt-get install zsh
chsh -s `which zsh`

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install rust tools
cargo install eza bat du-dust bottom starship ripgrep

# X setup
sudo apt-get install \
    bspwm polybar sxhkd dmenu \
    xsel xclip xdotool feh nsxiv maim \
    libjpeg-progs imagemagick \
    tesseract-ocr tesseract-ocr-eng tesseract-ocr-rus tesseract-ocr-ell \
    zathura zathura-ps zathura-pdf-poppler zathura-djvu \
    firefox-esr libreoffice \
    blueman network-manager-applet

# fonts
sudo apt-get install \
    fonts-noto-color-emoji \
    fonts-material-design-icons-iconfont

### Software I prefer to build from sources
mkdir $HOME/soft

# Install neovim
cd $HOME/soft
git clone --depth=1 https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=Release
make CMAKE_INSTALL_PREFIX=$HOME/.local install

#echo "Neovim version:"
#./build/bin/nvim --version | grep ^Build

mkdir -p $HOME/.config
git clone --depth=1 https://github.com/olekhov/init.lua $HOME/.config/nvim


# Install st-term
# TODO: add missing packages
sudo apt-get install x11proto-dev fontconfig 

cd $HOME/soft
git clone --depth=1 https://github.com/olekhov/st.git
cd st
make DESTPREFIX=$HOME/.local install


### Install dotfiles and configs
cd $HOME/soft
git clone --depth=1 https://github.com/olekhov/my-config
cd my-config

for f in `pwd`/dotfiles/* ; do
    ln -s $f $HOME/`basename $f`
done

mkdir $HOME/.config
for f in `pwd`/config ; do
    ln -s $f $HOME/.config/`basename $f`
done

# SSH agent user service
# Rationale: start agent on remote logins
mkdir -p $HOME/.config/systemd/user
ln -s `pwd`/systemd/ssh-agent.service $HOME/.config/systemd/user
#TODO: Enable ssh-agent service
