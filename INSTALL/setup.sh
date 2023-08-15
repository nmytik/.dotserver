#!/bin/sh

# Progress status:
##   navidrome.sh    [DONE]
##  qbittorrent.sh  [DONE]
##  jellyfin.sh     [TODO]
##  netbox.sh       [TODO]
##  hardenssh.sh    [TODO]

dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

#   Vars
    dir_dotrepo="${HOME}/.dotserver"
    dir_cache="${HOME}/.cache"

    message_longwarn="###########################################"
    message_longdash="----------------------"
    message_execroot="# The following commands will run as ROOT #"

    higher_word=0
    table_spacer=6

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

# TODO:
# Build automatically from a list
# Builder:
list_system="Repositories Software Symlinks ZSHShellChange"
list_selfhosted="Apache2 Bitwarden BookStack Cacti DokuWiki Drupal ElasticSearch GhostCMS GitLab Grafana Grocy HomeAssistant Jellyfin Joomla! Mattermost MediaWiki Moodle MyBB NGINXProxy Manager Navidrome NetBox NextCloud OpenMediaVault PHPMyAdmin PrestaShop Rocket.Chat SimpleMachines Forum Snipe-IT NGINX TeamPass TinyTiny RSS UptimeKuma Wordpress draw.io libreNMS openHAB openNMS osTicket phpBB qBittorrent"

set -- ${list_system}
for item_system in $@ do
    current_word=${#$@}
    if [ current_word -gt higher_word ] ; then
        higher_word=$current_word
    fi
done

set -- ${list_selfhosted}
for item_selfhosted in $@ do
    current_word=${#$@}
    if [ current_word -gt higher_word ] ; then
        higher_word=$current_word
    fi
done


printf '%s\n'   "" \
                "Select an option:" \
                "----------" \
                "| System |" \
printf -- '-%.0s' {1..${higher_word}+${table_space}}; printf '%s\n' ""

set -- ${list_system}
for item_system in $@ do
    current_word=${#$@}
done

                "| [ ] Repositories          | [ ] Software              | [ ] Symlinks              | [ ] ZSH Shell Change      |" \

printf '%s\n'   "-----------------------------------------------------------------------------------------------------------------" \
                "" \
                "=================================================================================================================" \

printf '%s\n'   "" \
                "---------------" \
                "| Self Hosted |" \
                "-----------------------------------------------------------------------------------------------------------------" \

                "| [ ] NetBox                | [ ] Snipe-IT              | [ ] Wordpress             | [ ] GhostCMS              |" \

printf '%s\n'   "-----------------------------------------------------------------------------------------------------------------" \
                "                                                                                    | [ ] None // Abort         |" \
                "                                                                                    -----------------------------" \
                "" \

##################################################################################################################################
printf '%s\n'   "" \
                "Select an option:" \
                "----------" \
                "| System |" \
                "-----------------------------------------------------------------------------------------------------------------" \
                "| [ ] Repositories          | [ ] Software              | [ ] Symlinks              | [ ] ZSH Shell Change      |" \
                "-----------------------------------------------------------------------------------------------------------------" \
                "" \
                "=================================================================================================================" \
                "" \
                "---------------" \
                "| Self Hosted |" \
                "-----------------------------------------------------------------------------------------------------------------" \
                "| [ ] NetBox                | [ ] Snipe-IT              | [ ] Wordpress             | [ ] GhostCMS              |" \
                "| [ ] Grocy                 | [ ] Joomla!               | [ ] Drupal                | [ ] MyBB                  |" \
                "| [ ] phpBB                 | [ ] TeamPass              | [ ] Bitwarden             | [ ] PHPMyAdmin            |" \
                "| [ ] MediaWiki             | [ ] DokuWiki              | [ ] NGINX Proxy Manager   | [ ] qBittorrent           |" \
                "| [ ] NextCloud             | [ ] Mattermost            | [ ] Rocket.Chat           | [ ] Simple Machines Forum |" \
                "| [ ] Jellyfin              | [ ] Navidrome             | [ ] libreNMS              | [ ] openNMS               |" \
                "| [ ] PrestaShop            | [ ] Tiny Tiny RSS         | [ ] HomeAssistant         | [ ] openHAB               |" \
                "| [ ] Moodle                | [ ] Grafana               | [ ] ElasticSearch         | [ ] OpenMediaVault        |" \
                "| [ ] Cacti                 | [ ] draw.io               | [ ] osTicket              | [ ] GitLab                |" \
                "| [ ] Uptime Kuma           | [ ] BookStack             | [ ] Sole Apache2          | [ ] Sole NGINX            |" \
                "| [ ]                       | [ ]                       | [ ]                       | [ ]                       |" \
                "| [ ]                       | [ ]                       | [ ]                       | [ ]                       |" \
                "-----------------------------------------------------------------------------------------------------------------" \
                "                                                                                    | [ ] None // Abort         |" \
                "                                                                                    -----------------------------" \
                "" \

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
 
