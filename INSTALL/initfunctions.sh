func_def_distro() #{{{1
{
    # Distribuitions have different package names and software paths.
    case ${ID} in
        "opensuse-tumbleweed")
            pkgmgr="zypper"
            pkginst="zypper install -y"
            repo_flag="opensuse-tumbleweed"
            zsh_inst_folder="/usr/share/zsh"

            sw_fd="fd"
            sw_fdzshcompletion="fd-zsh-completion"
            sw_fzftmux="fzf-tmux"
            sw_fzfzshcompletion="fzf-zsh-completion"
            sw_shellcheck="ShellCheck"
            sw_vimdata="vim-data"
            ;;

        "debian")
            pkgmgr="apt"
            pkginst="apt install -y"
            repo_flag="debian"
            zsh_inst_folder="/usr/share/zsh"

            sw_fd="fd-find"
            sw_fdzshcompletion=""
            sw_fzftmux=""
            sw_fzfzshcompletion=""
            sw_shellcheck="ShellCheck"
            sw_vimdata="vim-common"
            ;;

        "almalinux")
            pkgmgr="dnf"
            pkginst="dnf install -y"
            repo_flag="almalinux"
            zsh_inst_folder="/usr/share/zsh"

            sw_fd="fd"
            sw_fdzshcompletion=""
            sw_fzftmux=""
            sw_fzfzshcompletion=""
            sw_shellcheck="ShellCheck"
            sw_vimdata=""
            ;;

        *)
            printf '%s\n'   "This script doesn't support distribuition: ${ID}" \
                            "Exiting."
            exit 0
            ;;

    esac
}

func_def_host() #{{{1
{
    # dmi directory indicates a physical machine.
    if [ -d "/sys/devices/virtual/dmi" ]
    then
        current_host="$(cat /sys/devices/virtual/dmi/id/board_vendor) $(cat /sys/devices/virtual/dmi/id/product_version) - $(cat /sys/devices/virtual/dmi/id/product_name)"

    # WT_SESSION environment variable available in WSL1 and WSL2
    elif [ -n "${WT_SESSION}" ] ; then current_host="Windows Subsystem for Linux" ;

    # Last resort to fill current_host instead of garbage
    else current_host="None" ;
    fi
}

func_inst_repository() #{{{1
{
    printf '%s\n'   "Repositories" \
                    "${message_longdash}" \
                    ""

    printf '%s\n'   "${message_longwarn}" "${message_execroot}" "${message_longwarn}" \
                    ""

    case "${repo_flag}" in
        *)
            printf '%s\n' "No repository to add."
            ;;
    esac

    printf '%s\n' ""

    sleep 3s
}

func_inst_software() #{{{1
{
    printf '%s\n'   "Software" \
                    "${message_longdash}" \
                    ""

    printf '%s\n'   "${message_longwarn}" "${message_execroot}" "${message_longwarn}" \
                    ""

    # SSH and TTY session
    if [ "${XDG_SESSION_TYPE}" = "tty" ] && [ -n "${SSH_CLIENT}" ]; then su -c "${pkginst} ${list_server_cli}"; fi;

    # SSH and KDE session
    if [ "${XDG_SESSION_DESKTOP}" = "KDE" ] && [ "${DISPLAY}" = ":0.0" ]; then su -c "${pkginst} ${list_server_cli} ${list_server_gui} ${list_kde_basics}"; fi;

    # Install packages using current_host as a filter
    case ${current_host} in
        "Windows Subsystem for Linux")
            (su -c "${pkginst} ${list_terminal}") ;
                if [ "${ID}" = "opensuse-tumbleweed" ] ; then (su -c "${pkginst} -t pattern ${list_wsl_pattern}") ; fi
            ;;

        # TODO: SSH Sessions
        # "SSH Session")
        # ;;

        *)
            # This section installs packages from generic lists since no host was defined
            # KDE only
            # TODO: Gnome, XFCE, etc.
            # TODO: Replace "if" with "case switch"
            case ${XDG_SESSION_DESKTOP} in
                *) ;;
    esac

    printf '%s\n' ""

    sleep 3s
}

func_inst_symlinks() #{{{1
{
    printf '%s\n'   "Symlinking" \
                    "${message_longdash}" \
                    ""

    [ -d "${HOME}"/.vim ]               && rm -rf "${HOME}"/.vim
    [ -d "${HOME}"/.config/tmux ]       && rm -rf "${HOME}"/.config/tmux

    # Files.
    ln -vsf "${dir_dotroot}"/config/zsh/zshrc   "${HOME}"/.zshrc
    ln -vsf "${dir_dotroot}"/config/vim/vimrc   "${HOME}"/.vimrc

    # Directories.
    ln -vsf "${dir_dotroot}"/config/vim         "${HOME}"/.vim
    ln -vsf "${dir_dotroot}"/config/tmux        "${HOME}"/.config/tmux

    printf '%s\n' ""

    sleep 3s
}

func_inst_gitsubmodules() #{{{1
{
    printf '%s\n'   "Syncing git submodules" \
                    "${message_longdash}" \
                    ""

    # A repository with submodules already added must be initiated.
    (cd "${dir_dotroot}" && git submodule update --init --recursive) && printf '%s\n' "" "Submodules updated" ""

    printf '%s\n' ""

    sleep 3s
}

func_inst_vimhelptags() #{{{1
{
    printf '%s\n'   "Linking VIM Helptags" \
                    "${message_longdash}" \
                    ""

    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/dist/start/vim-airline/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/dist/start/vim-airline-themes/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/tpope/start/surround/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/tpope/start/commentary/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/tpope/start/fugitive/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/mbbill/start/undotree/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/junegunn/start/fzf/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/junegunn/start/fzf-vim/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/junegunn/start/goyo.vim/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/machakann/start/vim-highlightedyank/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/ntpeters/start/vim-better-whitespace/doc" -c q
    vim -u NONE -c "helptags ${dir_dotroot}/config/vim/pack/preservim/start/vim-indent-guides/doc" -c q

    printf '%s\n'   "" \
                    "VIM Helptags linked" \
                    ""

    sleep 3s
}

func_inst_changeshell() #{{{1
{
    printf '%s\n'   "Changing to ZSH" \
                    "${message_longdash}" \
                    ""

    printf '%s\n' "Current shell: ${SHELL}"

    # Check if running shell is ZSH.
    if [ "${SHELL}" != "/usr/bin/zsh" ]
    then
        # Check if ZSH is installed.
        if [ ! -f "${zsh_inst_folder}" ]
        then
            # iSH uses a different method for shell changing.
            if [ "${current_host}" = "iOS/iPadOS" ]
            then
                sed -i 's/ash/zsh/g' /etc/passwd && printf '%s\n' "Replaced ash with zsh in /etc/passwd file, close and re-open iSH to apply."
            else
                # Change the shell
                chsh -s "$(which zsh)" && printf '%s\n' "Shell changed to ZSH." || printf '%s\n' "ERROR: Shell not changed."
            fi
        else
            printf '%s\n' "ZSH missing. Want to install? [y/n]: "
            read  -r optionzshchange
            if [ "${optionzshchange}" = "y" ]
            then
                ${pkginst} "zsh"
                func_inst_changeshell
            fi
        fi
    else
        printf '%s\n' "ZSH already running."
    fi

    printf '%s\n' ""

    sleep 3s
}

func_inst_rebuild_gitsubmodules() #{{{1
{
    printf '%s\n'   "Rebuilding git submodules" \
                    "${message_longdash}" \
                    ""
    previous_pwd="$(pwd)"

    # NOTE: submodule path is relative to root repository.
    (cd ${dir_dotroot} &&
        git submodule add https://github.com/romkatv/powerlevel10k              config/zsh/plugins/powerlevel10k
        git submodule add https://github.com/zsh-users/zsh-syntax-highlighting  config/zsh/plugins/zsh-syntax-highlighting
        git submodule add https://github.com/zsh-users/zsh-autosuggestions      config/zsh/plugins/zsh-autosuggestions
        git submodule add https://github.com/vim-airline/vim-airline            config/vim/pack/dist/start/vim-airline
        git submodule add https://github.com/vim-airline/vim-airline-themes     config/vim/pack/dist/start/vim-airline-themes
        git submodule add https://github.com/tpope/vim-surround                 config/vim/pack/tpope/start/surround
        git submodule add https://github.com/tpope/vim-commentary               config/vim/pack/tpope/start/commentary
        git submodule add https://github.com/tpope/vim-fugitive                 config/vim/pack/tpope/start/fugitive
        git submodule add https://github.com/junegunn/goyo.vim                  config/vim/pack/junegunn/start/goyo.vim
        git submodule add https://github.com/junegunn/limelight.vim             config/vim/pack/junegunn/start/limelight.vim
        git submodule add https://github.com/junegunn/fzf.vim                   config/vim/pack/junegunn/start/fzf.vim
        git submodule add https://github.com/junegunn/fzf                       config/vim/pack/junegunn/start/fzf
        git submodule add https://github.com/mbbill/undotree                    config/vim/pack/mbbill/start/undotree
        git submodule add https://github.com/machakann/vim-highlightedyank      config/vim/pack/machakann/start/vim-highlightedyank
        git submodule add https://github.com/junegunn/rainbow_parentheses.vim   config/vim/pack/junegunn/start/rainbow_parentheses.vim
        git submodule add https://github.com/preservim/vim-indent-guides        config/vim/pack/preservim/start/vim-indent-guides
        git submodule add https://github.com/ntpeters/vim-better-whitespace     config/vim/pack/ntpeters/start/vim-better-whitespace
        git submodule add https://github.com/ap/vim-css-color                   config/vim/pack/css-color/start/css-color
    )

    cd ${previous_pwd}

    printf '%s\n' ""

    sleep 3s
}
