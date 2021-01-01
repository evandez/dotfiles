#!/bin/zsh

# Install homebrew if necessary, otherwise just update it.
which -s brew &>/dev/null
if [ $? != 0 ]; then
  echo 'homebrew not found, installing it...'
  ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install) &>/dev/null
else
  echo 'updating homebrew...'
  brew update &>/dev/null
fi

# Install essential brew packages.
echo 'installing essential brew packages...'
packages=(
    freetype
    htop
    wget
)
brew install ${packages[@]} &>/dev/null

# Install essential brew casks.
echo 'installing essential casks...'
casks=(
    'spectacle'
    'visual-studio-code'
    'python@3.8'
    'mactex'
    'keepassxc'
)
brew cask install ${casks[@]} &>/dev/null

# Ensure we're working from a known directory.
ORIGIN=$(pwd)
cd $(dirname ${(%):-%N}) &>/dev/null
cd $(git rev-parse --show-toplevel) &>/dev/null

# Safe symbolic link.
slink() {
    local src=$1
    local link=$2
    if [ -L $link -o -r $link ]; then
        echo "destination $link exists, not linking"
    else
        echo "linking $src to $link"
        ln -s $src $link
    fi
}

# Link all dotfiles to the home directory, minus a few exceptions.
echo 'will start linking dotfiles'
dotfiles=("${(@f)$(find . -type f -name '.[^.]*' -not -name '.git')}")
for dotfile in $dotfiles
do
    slink $(pwd)/$(basename $dotfile) ~/$(basename $dotfile)
done

# Handle .ssh separately since it's a directory.
mkdir -p ~/.ssh
slink $(pwd)/.ssh/config ~/.ssh/config

cd $ORIGIN
echo '\ndone, please restart terminal to see changes'
echo '\nWARNING! you may still need to do the following:'
echo '  * migrate gpg2 keys from other devices'
echo '  * synchronize vscode settings via github'
echo
