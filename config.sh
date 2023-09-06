#!/bin/sh

# After clone the repository, run this script to configure
# environment, install depedencies and install Plug on neovim
# Configuration for Arch Linux with yay installed

install_depedencies()
{
    # ttf-agave-nerd: nerd font agave
    # python-pix: run pip installed programs isolated

    sudo pacman -S yay
    yay -S neovim nodejs npm java-openjdk python-pipx go ttf-agave-nerd ripgrep
}

install_language_servers()
{
    # install angularls
    sudo npm install -g @angular/language-server

    # install c and cpp language server
    yay -S ccls

    # install gopls
    go install golang.org/x/tools/gopls@latest

    # install languagetool language server ltex-ls
    yay -S ltex-ls-bin

    # install pylsp
    pipx install 'python-lsp-server[all]'

    # install pyright
    pipx install pyright

    # install typescript language server
    sudo npm install -g typescript-language-server

}

install_plugin_manager()
{
    # install plug - plugin manager
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # install all plugins
    nvim +PlugInstall +qall
}

configuration ()
{
    echo 'Neovim setup script'

    echo 'Install depedencies'
    install_depedencies

    echo 'Install LSPs'
    install_language_servers

    echo 'Install Plug and plugins'
    install_plugin_manager
}

configuration
