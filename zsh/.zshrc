###
# Author: Florent MARQUES
# Created: 2022/07/09 
#
# Inspired by: https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/gentoo.zsh-theme
###

ANTIGEN_PATH="$HOME/.antigen"

if [[ ! -e "$ANTIGEN_PATH" ]]; then
    mkdir -p "$ANTIGEN_PATH"
fi

if [[ ! -e "$ANTIGEN_PATH/antigen.zsh" ]]; then
    $(curl &>/dev/null)
    if [[ "$?" -eq 2 ]]; then
        curl -L git.io/antigen >"$ANTIGEN_PATH/antigen.zsh"
    else
        echo "cannot install antigen because curl is not install"
        exit 1
    fi
fi

source "$ANTIGEN_PATH/antigen.zsh"

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle command-not-found

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

## You can add here more bundles
## You can alse add bundles in ~/.perso/.zshrc
# to avoid configuring your .zshrc file when updating this script

antigen theme flomSStaar/Linux-Automation zsh/flomSStaar

antigen apply

# Additional configurations for zsh
if [[ -r "$HOME/.perso/.zshrc" ]]; then
    source "$HOME/.perso/.zshrc"
fi