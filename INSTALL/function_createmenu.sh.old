. software.sh


message_option_system="Select an option:\n----------\n| System |\n"
message_option_selfhd="| Self Hosted |\n"

biggest_word=0                  # Stores the biggest word in the list
table_spacefiller=0             #
table_prefix_content="| [ ] "   #
table_words_per_line=4          # Sets the number of words showing in a line

count_numitemsystem=0
count_numitemselfhosted=0
counter_spacer=0

for item_system in ${table_system} do
    if [ ${#item_system} >= ${#biggest_word} ] ; then biggest_word=${item_system} ; fi
    count_numitemsystem++;
done

for item_selfhosted in ${table_selfhosted} do
    if [ ${#item_selfhosted} >= ${#biggest_word} ] ; then biggest_word=${item_selfhosted} ; fi
    count_numitemselfhosted++;
done

# TODO: Get ${biggest_word} length

# | [ ] Repositories          |
# < 06 ><          22        >|
# | [ ] Extremely_unreal_surreal_gigantic_sized_word |
# | [ ] Symlinks |
# | [ ] Symlinks                                     |
#
# Print | and 6 spaces. Determine item size, subtract to total space, fill rest with space.
# NOTE: every item in the list has a space in the end.
#
# biggest_word - item_system = fill remaining with spaces
#

printf '%s\n'   "message_option_sys"
while [ ${counter_spacer} -lt ${#table_prefix_content} ]
do
    printf -- '-%.0s' {1..${#biggest_word}+${#table_startspacer_content}}; printf '%s\n' ""
done

#"| [ ] Repositories          | [ ] Software              | [ ] Symlinks              | [ ] ZSH Shell Change      |" \
for item_in_system in ${list_system} do
    table_spacefiller=${#biggest_word} - ${#item_in_system}

    printf '%s' "${table_prefix_content}${item_in_system}${table_spacefiller}"

    if [ counter_spacer % 4 == 0] ; then printf '%s' "|\n" ; fi

    if [ counter_spacer == count_numitemsystem ]
    then
        print
    fi
    counter_spacer++;
done

for item_in_selfhosted in ${list_selfhosted} do
    table_spacefiller=${#biggest_word} - ${#item_in_selfhosted}

    printf '%s' "${table_prefix_content}${item_in_selfhosted}${table_spacefiller}"

    if [ counter_spacer % 4 == 0] ; then printf '%s' "|\n" ; fi

    if [ counter_spacer == count_numitemselfhosted ]
    then
        printf '%s' "printspaceof{#biggest_word} |\n"
    fi
    counter_spacer++;
done

########################################################################################################################

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
