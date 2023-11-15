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

    func_inst_repository
    func_inst_repos
    func_inst_software
    func_inst_symlinks
    func_inst_apps
    func_inst_gitsubmodules
    func_inst_changeshell

printf '%s\n'   "#----------------------#" \
                "# Everything is ready! #" \
 
