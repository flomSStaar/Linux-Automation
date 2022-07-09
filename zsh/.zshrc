ANTIGEN_PATH="/usr/local/share/antigen"

# Config antigen
if [[ -r "$ANTIGEN_PATH/antigen.zsh" ]]; then
        ADOTDIR="$ANTIGEN_PATH/resources"
        if [[ ! -e "$ADOTDIR" ]]; then
                mkdir -p "$ADOTDIR"
        fi
        ANTIGEN_CACHE="$ADOTDIR/init.zsh"
        ANTIGEN_COMPDUMP="$ADOTDIR/.zcompdump"
        ANTIGEN_BUNDLE="$ADOTDIR/bundles"
        ANTIGEN_DEBUG_LOG=/dev/null

        source "$ANTIGEN_PATH/antigen.zsh"

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
