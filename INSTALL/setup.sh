#!/bin/sh

# Progress status:
##  navidrome.sh    [DONE]
##  qbittorrent.sh  [DONE]
##  jellyfin.sh     [TODO]
##  netbox.sh       [TODO]
##  hardenssh.sh    [TODO]

dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

#   Vars
#   -------------------------------
    dir_dotrepo="${HOME}/.dotserver"
    dir_cache="${HOME}/.cache"

    message_longwarn="###########################################"
    message_longdash="----------------------"
    message_execroot="# The following commands will run as ROOT #"

#   Source files
    . /etc/os-release

    #if [ ! -f "${dir}"/functions.sh ] \
    #    && [ ! -f "${dir}"/software.sh ] \
    #    && [ ! -f "${dir}"/netbox.sh ]; then
    #    printf '%s\n' "Missing install components. Aborting."
    #    exit 0
    #fi

#   Source file containing functions.
    . "${dir}"/functions.sh

#   Defines the package manager and software especific to the running distribution.
    func_def_distro

#   This needs to be here so it can load after the /func_def_distro/ function.
    . "${dir}"/software.sh

printf '%s' "Input: "
read -r choice

printf '%s\n' ""

case "${choice}" in
    1)
        inetbox
        ;;
    2)
        isnipe
        ;;
    3)
        install_repos
        ;;
    4)
        install_apps
        ;;
    5)
        install_symlinks
        ;;
    6)
        ;;
    7)
        install_shell_change
        ;;
    *)
        printf '%s\n' "Canceled or option not found."
        exit 0
        ;;
esac

printf '%s\n'   "#----------------------#" \
                "# Everything is ready! #" \
 
