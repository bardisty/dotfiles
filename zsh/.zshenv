# vim:fdm=marker:
#
#                                dP
#                                88
#              d888888b .d8888b. 88d888b. .d8888b. 88d888b. dP   .dP
#                 .d8P' Y8ooooo. 88'  `88 88ooood8 88'  `88 88   d8'
#               .Y8P          88 88    88 88.  ... 88    88 88 .88'
# .----------- d888888P `88888P' dP    dP `88888P' dP    dP 8888P' ------------.
# |::::::::::::........::......::..::::..::......::..::::..:.....::::::::::::::|
# |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::|
# |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::|
# |----------------------------------------------------------------------------|
# |     file | ~/.zshenv                                                       |
# |     desc | Zsh shell environment variables                                 |
# |   author | bardisty <b@bah.im>                                             |
# |   source | https://github.com/bardisty/dotfiles                            |
# | modified | Wed Jan 17 2018 08:24:51 PST -0800                              |
# `----------------------------------------------------------------------------'


# Contents {{{1                                                       :contents:
# _____________


    # 1 General ......................................... :general:
    # 2 History ......................................... :history:
    # 3 Path ............................................ :path:
    # 4 XDG Base Directories ............................ :xdg-base-directories:
    # 5 Zplug ........................................... :zplug:


    # 1 General                                           :general:
    #
    #     BROWSER..................Web browser
    #     EDITOR...................Text editor
    #     GOPATH...................Go workspace location
    #     LANG.....................Locale
    #     LS_COLORS................ls colors / highlighting
    #     TERMINAL.................Path to terminal executable
    #     zshenv_private...........It's a secret...
    #
    #
    # 2 History                                           :history:
    #
    #     HISTFILE.................Where to store command history
    #     HISTSIZE.................Save 999 trillion lines of history
    #     SAVEHIST.................Save 999 trillion lines of history
    #
    #
    # 3 Path                                              :path:
    #
    #     PATH.....................Array of directories to search for commands
    #
    #
    # 4 XDG Base Directories                              :xdg-base-directories:
    #
    #     XDG_CONFIG_HOME..........Where to store user-specific config files
    #     XDG_CACHE_HOME...........Where to store user-specific cached data
    #     XDG_DATA_HOME............Where to store user-specific data files
    #
    #
    # 5 Zplug                                             :zplug:
    #
    #     ZPLUG_HOME...............Zplug directory








# 1 General {{{1                                                       :general:
# ==============


    # Web browser
    export BROWSER=inox

    # Text editor
    export EDITOR=vim

    # Go workspace location / where to look for Go code
    #     * Also set in `~/.xinitrc`
    export GOPATH="${HOME}/src/go"

    # Default locale
    export LANG=en_US.UTF-8

    # Set `LS_COLORS` environment variable via the `dircolors` command
    #
    #     $ dircolors
    #     LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=...';
    #     export LS_COLORS
    #
    if command -v dircolors > /dev/null 2>&1; then
      eval "$(dircolors)"
    fi

    # Terminal
    export TERMINAL=/usr/bin/urxvtc

    # It's a secret...
    zshenv_private="${HOME}/.zsh.d/_zshenv.private.zsh"
    [ -f "$zshenv_private" ] && . "$zshenv_private"








# 2 History {{{1                                                       :history:
# ==============


    # Where to store command history
    export HISTFILE="${HOME}/.zsh_history"

    # Save 999 trillion lines of history
    export HISTSIZE=999999999999999
    export SAVEHIST="$HISTSIZE"








# 3 Path {{{1                                                             :path:
# ===========


    # Setup $PATH
    PATH_SCRIPT="${HOME}/.path"
    [ -x "$PATH_SCRIPT" ] && . "$PATH_SCRIPT"








# 4 XDG Base Directories {{{1                             :xdg-base-directories:
# ===========================


    # Where user-specific configurations should be written
    # (analogous to `/etc/`)
    export XDG_CONFIG_HOME="${HOME}/.config"

    # Where user-specific non-essential (cached) data should be written
    # (analogous to `/var/cache`)
    export XDG_CACHE_HOME="${HOME}/.cache"

    # Where user-specific data files should be written
    # (analogous to `/usr/share`)
    export XDG_DATA_HOME="${HOME}/.local/share"








# 5 Zplug {{{1                                                           :zplug:
# ============


    export ZPLUG_HOME="${HOME}/.zplug"

