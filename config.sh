#!/bin/sh

# install grip to preview markdown files
pip install grip
pip3 install grip

# install pynvim
pip install pynvim
pip3 install pynvim

# install jedi to python autocompletion
pip install jedi
pip3 install jedi

# install pylint to neomake use
pip install pylint
pip3 install pylint

# install python auto-format
pip install yapf
pip3 install yapf

# install plug - plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +q
