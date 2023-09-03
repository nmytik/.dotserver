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
    message_option_sys="Select an option:\n----------\n| System |\n"

    biggest_word=0          # Stores the biggest word in the list
    table_spacefiller=0     #

    table_startspacer_content="| [ ] "      #
    table_words_per_line=4                  # Sets the number of words showing in a line

    counter_spacer=0

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

for item_system in ${table_system} do
    if [ ${#item_system} >= ${#biggest_word} ] ; then
        biggest_word=${item_system}
    fi
done

for item_selfhosted in ${table_selfhosted} do
    if [ ${#item_selfhosted} >= ${#biggest_word} ] ; then
        biggest_word=${item_selfhosted}
    fi
done

# TODO: Get ${biggest_word} length

# | [ ] Repositories          |
# |< 6 ><          22        >|
# | [ ] Extremely_unreal_surreal_gigantic_sized_word |
# | [ ] Symlinks |
# | [ ] Symlinks                                     |
# Print | and 6 spaces. Determine item size, subtract to total space, fill rest with space.
# NOTE: every item in the list have a space in the end.
#
# biggest_word - item_system = fill remaining with spaces
#

printf '%s\n'   "message_option_sys"
while [ ${counter_spacer} -lt ${#table_startspacer_content} ]
do
    printf -- '-%.0s' {1..${#biggest_word}+${#table_startspacer_content}}; printf '%s\n' ""
done

for item_in_system in ${list_system} do
    table_spacefiller=${#biggest_word} - ${#item_in_system}
    printf '%s' "${table_startspacer_content}${item_in_system}${table_spacefiller}"
    #"| [ ] Repositories          | [ ] Software              | [ ] Symlinks              | [ ] ZSH Shell Change      |" \
done


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
 
