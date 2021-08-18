#!/bin/bash

check_sudo() {
    if [[ $(id -u) -ne 0 ]]; then
        error 'You must have administrator rights to run this script!'
        return 1
    fi
}

#Usage: update_packages [-q|--quiet]
update_packages() {
    local quiet=''
    while [[ "$#" -ne 0 ]]; do
        case "$1" in
        -q | --quiet)
            quiet='qq'
            ;;
        esac
        shift
    done

    [[ -z "$quiet" ]] && echo "Starting the package update..."

    sudo apt-get update "-y$quiet"
    sudo apt-get upgrade "-y$quiet"
    sudo apt-get dist-upgrade "-y$quiet"
    sudo apt-get autoremove "-y$quiet"

    [[ -z "$quiet" ]] && echo "Packages updated !"
}

#Usage: install_packages_from_file [-q|--quiet] file
install_packages_from_file() {
    local packagesfile="${@: -1}"
    local quiet=''
    while [[ "$#" -ne 0 ]]; do
        case "$1" in
        -q | --quiet)
            quiet='qq'
            ;;
        esac
        shift
    done

    if [[ -r "$packagesfile" ]]; then
        [[ -z "$quiet" ]] && echo "Starting the installation of packages from $packagesfile"
        sudo xargs -a "$packagesfile" apt-get install "-y$quiet"
        [[ -z "$quiet" ]] && echo "Package installation complete from $packagesfile"
    else
        [[ -z "$quiet" ]] && error "The packages file \"$packagesfile\" is missing!"
    fi
}
