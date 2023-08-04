#!/bin/sh

#   Functions
#       inetbox_rhel    -> Installs netbox in red hat enterprise linux distributions
#       inetbox_debian  -> Installs netbox in debian based distributions
#           inetbox_step1   -> Step 1 from netbox documentation: PostgreSQL
#           inetbox_step2   -> Step 2 from netbox documentation: Redis
#           inetbox_step3   -> Step 3 from netbox documentation: NetBox
#           inetbox_step4   -> Step 4 from netbox documentation: Gunicorn
#           inetbox_step5   -> Step 5 from netbox documentation: HTTP Server
#           inetbox_step6   -> Step 6 from netbox documentation: LDAP
#           inetbox_step7   -> Optional step from netbox documentation: Upgrading NetBox
#
#
dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

#   Vars
    dir_dotrepo="${HOME}/.dotserver"
    message_longwarn="###########################################"
    message_longdash="----------------------"
    message_execroot="# The following commands will run as ROOT #"

#   Source files
    . /etc/os-release

    if [ ! -f "${dir}"/functions.sh ] \
        && [ ! -f "${dir}"/software.sh ] \
        && [ ! -f "${dir}"/netbox.sh ]; then
        printf '%s\n' "Missing install components. Aborting."
        exit 0
    fi
 
#   Source file containing functions.
    . "${dir}"/functions.sh

#   Defines the package manager and software especific to the running distribution.
    func_def_distro
    
#   This needs to be here so it can load after the /func_def_distro/ function.
    . "${dir}"/software.sh
    . "${dir}"/netbox.sh

# TODO:
# Build automatically from a list

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
 
