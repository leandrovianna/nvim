#!/bin/sh

# After clone the repository, run this script to configure
# environment, install depedencies and install Plug on neovim

function require()
{
    cmd=$1
    if ! command -v $cmd &> /dev/null
    then
        echo "$cmd is required to be installed"
        exit
    fi
}

require nvim
require pip
require npm
require java

# install grip to preview markdown files
pip install grip

# install pynvim
pip install pynvim

# install pylsp
pip install 'python-lsp-server[all]'

# install typescript language server
sudo npm i -g typescript-language-server

# neo-vim should already be installed!

# install plug - plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
