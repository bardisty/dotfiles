# vim:foldmethod=marker:
#
#                        dP oo
#                        88
#               .d8888b. 88 dP .d8888b. .d8888b. .d8888b. .d8888b.
#               88'  `88 88 88 88'  `88 Y8ooooo. 88ooood8 Y8ooooo.
#               88.  .88 88 88 88.  .88       88 88.  ...       88
# .------------ `88888P8 dP dP `88888P8 `88888P' `88888P' `88888P' ------------.
# |::::::::::::::.......:..:..::.......::......:::......:::......::::::::::::::|
# |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::|
# |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::|
# |----------------------------------------------------------------------------|
# |     file | ~/.zsh.d/aliases/_desktop.zsh                                   |
# |     desc | Zsh shell command aliases                                       |
# |   author | bardisty <b@bah.im>                                             |
# |   source | https://github.com/bardisty/dotfiles                            |
# | modified | Wed Jan 17 2018 08:54:06 PST -0800                              |
# `----------------------------------------------------------------------------'


# Contents {{{1                                                       :contents:
# _____________


    # 1 Command Defaults .................................. :command-defaults:
    # 2 FASD .............................................. :fasd:
    # 3 Helpers ........................................... :helpers:
    # 4 History ........................................... :history:
    # 5 Misc .............................................. :misc:
    # 6 Package Management ................................ :package-management:
    # 7 Shortcuts ......................................... :shortcuts:








# 1 Command Defaults {{{1                                     :command-defaults:
# =======================


    # -i ... interactive; prompt before overwrite
    # -r ... recursive; copy directories recursively
    # -v ... verbose; explain what's being done
    alias cp="cp -irv"

    # -i ... interactive; prompt before overwrite
    # -v ... verbose; explain what's being done
    alias mv="mv -iv"

    # -I ... prompt once before removing more than three files, or when
    #        removing recursively; less intrusive than `-i'
    alias rm="rm -I"

    # --color ... colorize the output
    # -F ........ append indicator (one of */=>@|) to entries
    alias ls="ls --color -F"









# 2 FASD {{{1                                                             :fasd:
# ===========


    # Default fasd aliases:
    #
    #alias a='fasd -a'        # any
    #alias s='fasd -si'       # show / search / select
    #alias d='fasd -d'        # directory
    #alias f='fasd -f'        # file
    #alias sd='fasd -sid'     # interactive directory selection
    #alias sf='fasd -sif'     # interactive file selection
    #alias z='fasd_cd -d'     # cd, same functionality as j in autojump
    #alias zz='fasd_cd -d -i' # cd with interactive selection

    alias j="z"
    alias c="z"
    alias ct="f -e cat"
    alias m="f -e mpv"
    alias o="fasd -a -e mimeo"
    alias v="f -e vim"








# 3 Helpers {{{1                                                        :helper:
# ==============


    # findclass -- used to find the window class value of applications
    #
    # @usage: enter 'findclass' in terminal, then select the window you want
    alias findclass="xprop | grep -i 'class'"

    # findrole -- used to find WM_WINDOW_ROLE value. Useful for affecting
    # child windows such as instant messaging conversations, email compose
    # windows, etc.
    #
    # @usage: enter 'findroll' in terminal, then select the window you want
    alias findrole="xprop | grep -i 'role'"








# 4 History {{{1                                                       :history:
# ==============


    # `-i` ... YYYY-MM-DD HH:MM output
    alias history="fc -il 1"








# 5 Misc {{{1                                                             :misc:
# ===========


    alias wtcom="curl -s 'http://whatthecommit.com/index.txt'"
    alias cd..="cd .."








# 6 Package Management {{{1                                 :package-management:
# =========================


    # -u .............. update AUR packages
    # --noconfirm ..... do not prompt for any confirmation
    # --noedit ........ do not prompt to edit files
    alias aup="pacaur -u --noconfirm --noedit"

    # -S ...... synchronize packages
    # -cc ..... remove packages that are no longer installed from the cache
    #           as well as currently unused sync databases to free up disk
    #           space
    alias pcc="sudo pacman -Scc"

    # -S ..... syncronize packages
    # -y ..... download a fresh copy of the master package list
    # -u ..... upgrade all packages that are out-of-date
    alias pup="sudo pacman -Syu"








# 7 Shortcuts {{{1                                                   :shortcuts:
# ================


    alias aliases="cat ~/.zsh.d/aliases/*"
    alias chd="find . -type d -exec chmod 0755 {} \;"
    alias chf="find . -type f -exec chmod 0644 {} \;"
    alias ick="ack -i --pager='less -R -S -X'"
    alias k9="kill -9"
    alias ka="killall"
    alias opng="optipng -o7 -strip all"
    alias ra="ranger"
    alias t="tmsu -D ~/.tmsu/db"
    alias todo="vim ~/usr/doc/todo.txt"
    alias yb="youtube-dl -f bestvideo+bestaudio --restrict-filenames -4 --write-description --write-info-json --write-thumbnail --add-metadata --xattrs -o '%(uploader)s.%(upload_date)s.%(title)s.%(resolution)s.%(id)s.%(ext)s'"

    # ls
    alias l="ls -aFhl"
    alias ld="ls */"
    alias lm="ls -aFhlrt"
    alias lda="ls -a */"
    alias lft="ls -aFh --full-time"

    # Zplug
    alias zst="zplug status"
    alias zup="zplug update"

