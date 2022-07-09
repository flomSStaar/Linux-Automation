ANTIGEN_PATH="/usr/local/share/antigen/antigen.zsh"

# Config antigen
if [[ -r "$ANTIGEN_PATH" ]]; then
        source "$ANTIGEN_PATH"

        antigen use oh-my-zsh

        antigen bundle git
        antigen bundle pip
        antigen bundle command-not-found

        antigen bundle zsh-users/zsh-completions
        antigen bundle zsh-users/zsh-autosuggestions
        antigen bundle zsh-users/zsh-syntax-highlighting
        antigen bundle zsh-users/zsh-history-substring-search

        antigen theme flomSStaar/Linux-Automation zsh/flomSStaar

        antigen apply
else
        echo "Cannot load antigen"
fi
