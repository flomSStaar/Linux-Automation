#!/bin/bash

zsh_config() {
    local quiet=''
    local user=''
    local zsh_template='zsh/.zshrc_template.txt'
    local zsh_override=''
    while [[ $# -ne 0 ]]; do
        case "$1" in
        -q | --quiet)
            quiet='--quiet'
            ;;
        -u | --user)
            user="--user $2"
            ;;
        -zo | --zsh_override)
            zsh_override='--override'
            ;;
        -zt | --zsh_template)
            zsh_template="$2"
            shift
            ;;
        esac
        shift
    done
    [[ -z "$quiet" ]] && start_message
    install_zsh_packages "$quiet"
    fetch_antigen "$quiet"
    create_zshrc_file "$quiet" --input-file "$zsh_template" "$zsh_override"
    change_shell_to_zsh "$user" "$quiet"
    [[ -z "$quiet" ]] && end_message
}

start_message() {
    echo "Starting the installation of zsh..."
}

end_message() {
    echo "Zsh installation complete !"
    echo "You need to restart your terminal to finish the configuration"
}

#Usage: install_packages [-q|--quiet]
install_zsh_packages() {
    local quiet=''
    while [[ $# -ne 0 ]]; do
        case "$1" in
        -q | --quiet)
            quiet='q'
            ;;
        esac
        shift
    done
    for i in build-essential command-not-found curl git gnupg lsb-release zsh; do
        if [[ -z $(dpkg -l $i | grep 'ii') ]]; then
            sudo apt-get install $i "-y$quiet"
        fi
    done
}

#Usage: fetch_antigen [-q|--quiet] [-v|--verbose]
fetch_antigen() {
    local quiet=''
    local verbose=''
    while [[ $# -ne 0 ]]; do
        case "$1" in
        -q | --quiet)
            quiet='s'
            ;;
        -v | --verbose)
            verbose='v'
            ;;
        esac
        shift
    done
    [[ -n "$verbose" ]] && quiet=''

    local destpath="$HOME/.config/antigen"
    local destfile="$destpath/antigen.zsh"
    mkdir "-p$verbose" "$destpath"
    [[ ! -e "$destfile" ]] && curl "-L$quiet" git.io/antigen >"$destfile"
}

#Usage: create_zshrc_file [-q|--quiet] [-o|--override] [[-i|--input-file] file]
create_zshrc_file() {
    local quiet=0
    local override=0
    local filelocation=".zshrc_template"
    local destination="$HOME/.zshrc"
    while [[ $# -ne 0 ]]; do
        case "$1" in
        -q | --quiet)
            quiet=1
            ;;
        -o | --override)
            override=1
            ;;
        -i | --input-file)
            filelocation="$2"
            shift
            ;;
        esac
        shift
    done

    if [[ ! -e "$filelocation" ]]; then
        [[ $quiet -eq 0 ]] && error "Source file \"$filelocation\" does not exist"
        return 1
    fi

    # => Si existe et override = 1 ==> cp
    # => Si existe et override = 0 ==> rien
    # => Si existe pas ==> cp
    ([[ -e "$destination" ]] && [[ $override -eq 0 ]]) || cp "$filelocation" "$destination"
}

#==================
#Copy settings based on user
#==================
copy_p10k() {
    local filelocation=''
    local destination="$HOME/.p10k.zsh"
    #Choose the file based on user
    [[ $(id -u) = 0 ]] && filelocation='zsh/.p10kroot.zsh' || filelocation='zsh/.p10kflo.zsh'

    if [[ ! -e "$filelocation" ]]; then
        echo "copy_p10k: Source file \"$filelocation\" does not exist" >&2
        return 1
    elif ! cp -n "$filelocation" "$destination" 2>/dev/null; then
        echo "copy_p10k: Parameter file copy error" >&2
        return 1
    fi
    return 0
}

#Usage: change_shell_to_zsh [-q|--quiet] [[-u|--user] user]
change_shell_to_zsh() {
    local quiet=0
    local user=$USER
    while [[ $# -ne 0 ]]; do
        case "$1" in
        -q | --quiet)
            quiet=1
            ;;
        -u | --user)
            if getent passwd "$2" >/dev/null 2>&1; then
                user="$2"
                shift
            else
                error "Unknown user: $2"
                return 2
            fi
            ;;
        esac
        shift
    done

    #Check if zsh is installed
    if ! dpkg -l zsh | grep -wq ii; then
        [[ $quiet -eq 0 ]] && error 'You can''t change your shell to zsh because it is not installed !'
        [[ $quiet -eq 0 ]] && error 'If you want to install it, execute "sudo apt install zsh"'
        return 1
    fi

    if grep -w "$user" /etc/passwd | cut -d ':' -f 7 | grep -wq '/usr/bin/zsh'; then
        [[ $quiet -eq 0 ]] && echo "The current shell is already zsh for $user"
    else
        local previousshell=$(grep -w "$user" /etc/passwd | cut -d ':' -f 7 | rev | cut -d '/' -f 1 | rev)
        [[ $quiet -eq 0 ]] && echo "Shell change in progress from $previousshell to zsh for \"$user\""
        chsh -s /usr/bin/zsh $user
        [[ $quiet -eq 0 ]] && echo "Change made for \"$user\""
    fi
    return 0
}
