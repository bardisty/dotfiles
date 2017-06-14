#!/usr/bin/env sh
# vim:fdm=marker:
#
#                                  oo          oo   dP
#                                                   88
#                         dP.  .dP dP 88d888b. dP d8888P
#                          `8bd8'  88 88'  `88 88   88
#                          .d88b.  88 88    88 88   88
# .---------------------- dP'  `dP dP dP    dP dP   dP ------------------------.
# |:::::::::::::::::::::::..::::..:..:..::::..:..:::..:::::::::::::::::::::::::|
# |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::|
# |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::|
# |----------------------------------------------------------------------------|
# |     file | ~/.xinitrc                                                      |
# |     desc | X Window System initializer                                     |
# |   author | bardisty <b@bah.im>                                             |
# |   source | https://github.com/bardisty/dotfiles                            |
# | modified | Wed Jun 14 2017 11:19:11 PDT -0700                              |
# `----------------------------------------------------------------------------'


# Contents {{{1                                                       :contents:
# _____________


    # 1 External Sources ............................. :external-sources:
    # 2 X Environment Variables ...................... :x-environment-variables:
    # 3 General ...................................... :general:
    # 4 GnuPG ........................................ :gnupg:
    # 5 Background Processes ......................... :background-processes:
    # 6 Window Manager ............................... :window-manager:








# 1 External Sources {{{1                                     :external-sources:
# =======================


    SYS_RESOURCES=/etc/X11/xinit/.Xresources
    [ -f "$SYS_RESOURCES" ] && xrdb -merge "$SYS_RESOURCES"

    USER_RESOURCES="${HOME}/.Xresources"
    XRES_DOTDIR="${HOME}/.Xresources.d"
    [ -f "$USER_RESOURCES" ] && xrdb -merge -I"$XRES_DOTDIR" "$USER_RESOURCES"


    SYS_MODMAP=/etc/X11/xinit/.Xmodmap
    [ -f "$SYS_MODMAP" ] && xmodmap "$SYS_MODMAP"

    USER_MODMAP="${HOME}/.Xmodmap"
    [ -f "$USER_MODMAP" ] && xmodmap "$USER_MODMAP"


    if [ -d /etc/X11/xinit/xinitrc.d ]; then
      for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        # shellcheck source=/dev/null
        [ -x "$f" ] && . "$f"
      done
      unset f
    fi


    # shellcheck source=/home/bah/.xprofile
    [ -f .xprofile ] && . "${HOME}/.xprofile"








# 2 X Environment Variables {{{1                       :x-environment-variables:
# ==============================


    # Go workspace location / where to look for Go code
    #     * Also set in `~/.zshenv`
    export GOPATH="${HOME}/src/go"

    # Ensure GTK themes are applied uniformly
    #     * Use `lxappearance` to manage the config files
    export GTK2_RC_FILES="${HOME}/.gtkrc-2.0"
    export GTK_THEME="${HOME}/.config/gtk-3.0/settings.ini"

    # > Normally, the path should be set in `~/.zshenv`, but Arch Linux
    # > sources `/etc/profile` after sourcing `~/.zshenv`⁽¹⁾
    #
    # Source order:
    #     Login shell:
    #         ~/.zshenv -> /etc/profile -> ~/.zprofile
    #     X session:
    #         ~/.zshenv -> /etc/profile -> ~/.xinitrc (X initialized) -> ~/.zshenv (e.g., terminal opened)
    #
    # To prevent the $PATH from being overwritten...
    #     * ...in a login shell, set it in `~/.zprofile`
    #     * ...at the start of an X session, set it in `~/.xinitrc`
    #
    # 1. https://wiki.archlinux.org/index.php/Zsh#Configuring_.24PATH

    # Ensure $PATH is set for any commands or scripts invoked before
    # `~/.zshenv` is sourced (again)
    PATH_SCRIPT="${HOME}/.path"
    # shellcheck source=/home/bah/.path
    [ -x "$PATH_SCRIPT" ] && . "$PATH_SCRIPT"








# 3 General {{{1                                                       :general:
# ==============


    # Setup Xorg(1) font paths {{{2
    xorg_font_paths() {
      # Check if path exists before adding it to Xorg font paths
      for font_path in "$@"; do
        [ -d "$font_path" ] && xset +fp "$font_path"
      done

      # Tell X server to reread the font database
      xset fp rehash

      return 0
    }

    xorg_font_paths "${HOME}/.local/share/fonts/" \
                    /usr/share/fonts/local/ \
                    /usr/share/fonts/misc/


    # Fix the 'X' cursor issue {{{2
    xsetroot -cursor_name left_ptr &


    # Set wallpaper with feh(1) {{{2
    FEHBG="${HOME}/.fehbg"
    [ -x "$FEHBG" ] && "$FEHBG" &








# 4 GnuPG {{{1                                                           :gnupg:
# ============


    # dirmngr -- access OpenPGP keyservers; CRL and OCSP daemon {{{2
    dirmngr --daemon --homedir "${HOME}/.gnupg" --options "${HOME}/.gnupg/dirmngr.conf"


    # GnuPG Agent {{{2
    # https://wiki.archlinux.org/index.php/GnuPG#SSH_agent

    # Start the gpg-agent if not already running
    if ! pgrep -x -u "${USER}" gpg-agent > /dev/null 2>&1; then
      gpg-connect-agent /bye > /dev/null 2>&1
    fi

    # Set SSH to use gpg-agent
    unset SSH_AGENT_PID
    if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
      SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
      export SSH_AUTH_SOCK
    fi

    # Set GPG TTY
    GPG_TTY=$(tty)
    export GPG_TTY

    # Refresh gpg-agent tty in case user switches into an X session
    gpg-connect-agent updatestartuptty /bye > /dev/null








# 5 Background Processes {{{1                             :background-processes:
# ===========================


    # Run command if it exists {{{2
    if_cmd_exists() {
      if command -v "$1" > /dev/null 2>&1; then
        # Command exists, get full path to binary
        cmd_bin=$(command -v "$1")

        # Remove the first positional parameter (`$1`, the command) from
        # `$@` so `$@` only contains provided command arguments
        shift

        # Run command, with arguments if any
        $cmd_bin "$@"

        return 0
      else
        return 127
      fi
    }


    # autoup -- automatically upload files created in a directory {{{2
    # gopher://z3bra.org/notes -> uploadir
    AUTOUP="${HOME}/bin/autoup"
    [ -x "$AUTOUP" ] && "$AUTOUP" &


    # compton -- composite manager {{{2
    # https://github.com/chjj/compton
    if_cmd_exists compton -b --config "${HOME}/.config/compton.conf"


    # jackdbus -- JACK audio connection kit {{{2
    if_cmd_exists jack_control start &


    # nm-applet -- NetworkManager systray applet {{{2
    if_cmd_exists nm-applet &


    # redshift -- adjust color temp of display according to time of day {{{2
    if_cmd_exists redshift &


    # remind -- a sophisticated reminder service
    if_cmd_exists remind -z -k"notify-send -u critical 'REMINDER' '%s'" "${HOME}/.reminders" &


    # sxhkd -- simple X hotkey daemon {{{2
    # https://github.com/baskerville/sxhkd
    if_cmd_exists sxhkd &


    # thyme -- track which applications you use and for how long {{{2
    # https://github.com/sourcegraph/thyme
    THYME="${HOME}/bin/thyme.sh"
    THYME_CRON="${HOME}/bin/thyme-cron.sh"
    [ -x "$THYME" ] && "$THYME" &
    [ -x "$THYME_CRON" ] && "$THYME_CRON" &


    # urxvtd -- urxvt daemon (for use with urxvtc) {{{2
    if_cmd_exists urxvtd -q -o -f &


    # unclutter -- hide mouse cursor when not in use {{{2
    # https://github.com/Airblader/unclutter-xfixes
    if_cmd_exists unclutter --timeout 5 -b








# 6 Window Manager {{{1                                         :window-manager:
# =====================


    exec i3

