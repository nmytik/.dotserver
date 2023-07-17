func_def_distro()
{
    case ${ID} in
        "opensuse-tumbleweed")
            pkgmgr="zypper install -y";
            repo_flag="opensuse-tumbleweed"

            sw_fd="fd"
            sw_fdzshcompletion="fd-zsh-completion"
            sw_fzftmux="fzf-tmux"
            sw_fzfzshcompletion="fzf-zsh-completion"
            sw_vifmcolors="vifm-colors"
            sw_vimdata="vim-data"
            ;;

        "debian")
            pkgmgr="apt install -y";   
            repo_flag="debian"

            sw_fd="fd-find"
            sw_fdzshcompletion=""
            sw_fzftmux=""
            sw_fzfzshcompletion=""
            sw_vifmcolors=""
            sw_vimdata="vim-common"
            ;;

        "archlinux")
            pkgmrg="pacman -Sy"
            repo_flag="arch"

            sw_fd=""
            sw_fdzshcompletion=""
            sw_fzftmux=""
            sw_fzfzshcompletion=""
            sw_vifmcolors=""
            sw_vimdata=""
            ;;

        "almalinux")
            pkgmgr="dnf install -y";   
            repo_flag="almalinux"

            sw_fd="fd"
            sw_fdzshcompletion=""
            sw_fzftmux=""
            sw_fzfzshcompletion=""
            sw_vifmcolors=""
            sw_vimdata=""
            ;;

        *)
            printf '%s\n' "Unknown distro!"
            exit 0
            ;;

    esac
}

install_apps()
{
    printf '%s\n'   "Software"
                    "${message_longdash}"

    printf '%s\n'   ${message_longwarn} "${message_execroot}" ${message_longwarn}

    # SSH and TTY session
    if [ "${XDG_SESSION_TYPE}" = "tty" ] && [ -n "${SSH_CLIENT}" ]; then su -c "${pkgmgr} ${list_server_cli}"; fi;

    # SSH and KDE session
    if [ "${XDG_SESSION_DESKTOP}" = "KDE" ] && [ "${DISPLAY}" = ":0.0" ]; then su -c "${pkgmgr} ${list_server_cli} ${list_server_gui} ${list_kde_basics}"; fi;

    printf '%s\n' ""

    sleep 3s
}

install_symlinks()
{
    printf '%s\n'   "Symlinking" \
                    "${message_longdash}"

    [ -d "${HOME}"/.vim ]               && rm -rf "${HOME}"/.vim
    [ -d "${HOME}"/.config/vifm ]       && rm -rf "${HOME}"/.config/vifm
    [ -d "${HOME}"/.config/tmux ]       && rm -rf "${HOME}"/.config/tmux

    # Files
    ln -vsf "${dir_dotrepo}"/config/zsh/    "${HOME}"/.zshrc
    ln -vsf "${dir_dotrepo}"/config/vim/    "${HOME}"/.vimrc

    # Directories
    ln -vsf "${dir_dotrepo}"/config/vim     "${HOME}"/.vim
    ln -vsf "${dir_dotrepo}"/config/vifm    "${HOME}"/.config/vifm
    ln -vsf "${dir_dotrepo}"/config/tmux    "${HOME}"/.config/tmux

    printf '%s\n' ""

    sleep 3s
}

