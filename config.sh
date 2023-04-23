#!/bin/sh

# After clone the repository, run this script to configure
# environment, install depedencies and install Plug on neovim

# install grip to preview markdown files
pip install grip

# install pynvim
pip install pynvim

# install pylsp
pip install 'python-lsp-server[all]'

# install yapf (autoformat python)
pip install yapf

# install jq (autoformat json)
pamac install jq

# neo-vim should already be installed!

# install plug - plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall! +q

# Run Grammarous for the first time to download LanguageTool
nvim +GrammarousCheck +q

# Install COQ depedencies
nvim +COQdeps
