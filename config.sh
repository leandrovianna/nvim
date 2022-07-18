#!/bin/sh

# After clone the repository, run this script to configure
# enviorment, install depedencies and install Plug on neovim

# install grip to preview markdown files
pip install grip

# install pynvim
pip install pynvim

# install pylsp
pip install 'python-lsp-server[all]'

# neo-vim should already be installed!

# install plug - plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +q

# Download a font to use on Terminal
sh ./download_font.sh

# Run Grammarous for the first time to download LanguageTool
nvim +GrammarousCheck +q
