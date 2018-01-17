#!/usr/bin/env zsh
# vim:fdm=marker:
#
#                                             dP
#                                             88
#                           d888888b .d8888b. 88d888b.
#                              .d8P' Y8ooooo. 88'  `88
#                            .Y8P          88 88    88
# .------------------------ d888888P `88888P' dP    dP ------------------------.
# |:::::::::::::::::::::::::........::......::..::::..:::::::::::::::::::::::::|
# |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::|
# |::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::|
# |----------------------------------------------------------------------------|
# |     file | ~/.zshrc                                                        |
# |     desc | Zsh(1) shell configuration                                      |
# |   author | bardisty <b@bah.im>                                             |
# |   source | https://github.com/bardisty/dotfiles                            |
# | modified | Wed Jan 17 2018 08:23:41 PST -0800                              |
# `----------------------------------------------------------------------------'


# Contents {{{1                                                       :contents:
# _____________


    # 1 zplug ................................... :zplug:
    # 2 Appearance .............................. :appearance:
    # 3 Functions ............................... :functions:
    # 4 History ................................. :history:
    # 5 Window Titles ........................... :window-titles:
    # 6 Alias Tips .............................. :alias-tips:
    # 7 Zsh Auto Suggestions .................... :zsh-auto-suggestions:
    # 8 Zsh History Substring Search ............ :zsh-history-substring-search:
    # 9 Zsh Syntax Highlighting ................. :zsh-syntax-highlighting:








# 1 zplug {{{1                                                           :zplug:
# ============


    # Install zplug if it's not installed
    if [[ ! -d $ZPLUG_HOME ]]; then
      git clone https://github.com/zplug/zplug $ZPLUG_HOME
    fi

    # Init zplug
    source $ZPLUG_HOME/init.zsh

    # Let zplug manage zplug for easy updating
    zplug "zplug/zplug", hook-build:'zplug --self-manage'

    # Command aliases
    zplug "${HOME}/.zsh.d/aliases", from:local, use:"_*.zsh"

    # Zsh theme
    zplug "${HOME}/.zsh.d/themes", from:local, as:theme, use:"steeef-mod.zsh-theme"

    # Oh-My-Zsh libs
    zplug "lib/clipboard", from:oh-my-zsh
    zplug "lib/completion", from:oh-my-zsh
    zplug "lib/git", from:oh-my-zsh, if:"(( $+commands[git] ))"
    zplug "lib/grep", from:oh-my-zsh
    zplug "lib/misc", from:oh-my-zsh
    zplug "lib/spectrum", from:oh-my-zsh
    zplug "lib/theme-and-appearance", from:oh-my-zsh
    ENABLE_CORRECTION="true"
    zplug "lib/correction", from:oh-my-zsh

    # Oh-My-Zsh plugins
    zplug "plugins/archlinux",   from:oh-my-zsh, if:"[[ $(uname -r) == *MANJARO || $(uname -r) == *ARCH ]]"
    zplug "plugins/colored-man", from:oh-my-zsh
    zplug "plugins/extract",     from:oh-my-zsh
    zplug "plugins/fasd",        from:oh-my-zsh, if:"(( $+commands[fasd] ))"
    zplug "plugins/git",         from:oh-my-zsh, if:"(( $+commands[git] ))",  defer:0
    zplug "plugins/npm",         from:oh-my-zsh, if:"(( $+commands[npm] ))"
    zplug "plugins/pass",        from:oh-my-zsh, if:"(( $+commands[pass] ))"
    zplug "plugins/pip",         from:oh-my-zsh, if:"(( $+commands[pip] ))"
    zplug "plugins/rbenv",       from:oh-my-zsh, if:"(( $+commands[rbenv] ))"
    zplug "plugins/systemd",     from:oh-my-zsh
    zplug "plugins/tmux",        from:oh-my-zsh, if:"(( $+commands[tmux] ))", defer:0
    zplug "plugins/tmuxinator",  from:oh-my-zsh, if:"(( $+commands[tmuxinator] ))"
    zplug "plugins/vi-mode",     from:oh-my-zsh
    zplug "plugins/virtualenv",  from:oh-my-zsh, if:"(( $+commands[python] ))"

    # Node version manager
    zplug "lib/nvm",                    from:oh-my-zsh, if:"[[ -a '/usr/share/nvm/init-nvm.sh' ]]"
    zplug "/usr/share/nvm/init-nvm.sh", from:local,     if:"[[ -a '/usr/share/nvm/init-nvm.sh' ]]", defer:0
    zplug "/usr/share/zaw/zaw.zsh",     from:local,     if:"[[ -a '/usr/share/zaw/zaw.zsh' ]]"

    # Alias tips, helps you remember shell aliases and Git aliases
    zplug "djui/alias-tips"

    # git.io helper
    #   * e.g., `gitio bardisty/dotfiles etc` -> `git.io/etc`
    zplug "denysdovhan/gitio-zsh"

    # Directory listings with git features
    zplug "supercrabtree/k"

    # Fish-like auto-suggestions
    zplug "zsh-users/zsh-autosuggestions"

    # Zsh port of Fish shell's history search feature
    #     *  must be loaded after `zsh-users/zsh-syntax-highlighting`
    zplug "zsh-users/zsh-history-substring-search", defer:3

    # Fish-like syntax highlighting
    #     *  must be loaded after executing compinit command and sourcing
    #        other plugins (taken care of with `defer` option)
    zplug "zsh-users/zsh-syntax-highlighting", defer:2

    # fzf (command-line fuzzy finder) key bindings
    zplug "/usr/share/fzf/key-bindings.zsh", from:local, if:"[[ -a '/usr/share/fzf/key-bindings.zsh' ]]"

    # https://wiki.archlinux.org/index.php/Pkgfile#Command_not_found
    CNF="/usr/share/doc/pkgfile/command-not-found.zsh"
    zplug "$CNF", from:local, if:"[[ -a '$CNF' ]]"

    # Ask to install any plugins that are not yet installed
    if ! zplug check --verbose; then
      printf "Install? [y/N]: "
      if read -q; then
        echo; zplug install
      fi
    fi

    # Source plugins and add commands to `$PATH`
    zplug load --verbose








# 2 Appearance {{{1                                                 :appearance:
# =================


    # `ls` colors
    #
    # Use color specifications already set up for the GNU version of `ls`
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}








# 3 Functions {{{1                                                   :functions:
# ================


    fpath=(~/.zsh.d/functions $fpath)
    autoload -Uz ${fpath[1]}/*(:t) compaudit compinit








# 4 History {{{1                                                       :history:
# ==============


    setopt append_history
    setopt extended_history
    setopt hist_expire_dups_first
    setopt hist_ignore_dups
    setopt hist_ignore_space
    setopt hist_verify
    setopt inc_append_history
    setopt share_history


    # Log commands to daily log files
    #     * Used in `precmd()` function. See :window-titles: section.
    history_logs() {
      if [[ "$(hostname)" == *dsk* ]] || [[ "$(hostname)" == *lap* ]] || [[ "$(hostname)" == *linuxiso* ]]; then

        # Where to store history log files
        local LOG_DIR="${HOME}/var/log/history"

        # Original source: https://news.ycombinator.com/item?id=11806767
        local LOG_CMD='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d %H:%M:%S") $(pwd) $(fc -l -1)" >>! "$LOG_DIR"/history-$(date "+%Y-%m-%d").log; fi'

        if [[ -d "$LOG_DIR" ]]; then
          eval "$LOG_CMD"
        else
          if ! mkdir -p "$LOG_DIR"; then
            printf %s\\n "Error: could not create history logs directory! \
              Ensure the `LOG_DIR` variable in `.zshrc` is set to the right path."
          else
            eval "$LOG_CMD"
          fi
        fi

      fi
    }








# 5 Window Titles {{{1                                           :window-titles:
# ====================


    preexec() {
      # Set window title to expanded command (shell alias -> full command) just
      # before executing
      if (( $+SSH_CONNECTION )); then
        # user@host: command
        print -Pn "\e]0;%n@%m: ${2}\a"
      else
        # commmand
        printf "\x1b]0;%s\x07" "$2"
      fi
    }

    precmd() {
      # Set window title to current working directory when returning from a
      # command
      case "$TERM" in
        *rxvt*)
          if (( $+SSH_CONNECTION )); then
            # user@host: ~/directory
            print -Pn "\e]0;%n@%m: %~\a"
          else
            # ~/directory
            print -Pn "\e]0;%~\a"
          fi
          ;;
      esac

      # Log commands to daily log files, see :history:
      history_logs
    }








# 6 Alias Tips {{{1                                                 :alias-tips:
# =================


    # https://github.com/djui/alias-tips
    if zplug check djui/alias-tips; then
      # Customize the output
      export ZSH_PLUGINS_ALIAS_TIPS_TEXT="alias: "

      # Exclude some aliases
      #export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="ll"

      # Expand command to get best alias
      export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=1
    fi








# 7 Zsh Auto Suggestions {{{1                             :zsh-auto-suggestions:
# ===========================


    # https://github.com/zsh-users/zsh-autosuggestions
    if zplug check zsh-users/zsh-autosuggestions; then
      # Ctrl-F to autocomplete the next word in the suggestion
      bindkey '^f' vi-forward-word

      # Ctrl-E to autocomplete the entire suggestion
      bindkey '^e' end-of-line
    fi








# 8 Zsh History Substring Search {{{1             :zsh-history-substring-search:
# ===================================


    # Configuration variables
    if zplug check zsh-users/zsh-history-substring-search; then
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=green,fg=white,bold"
    fi

    # Key binds
    if zplug check zsh-users/zsh-history-substring-search; then
      zmodload zsh/terminfo

      # For most systems
      if [[ -n "$terminfo[kcuu1]" ]]; then
        bindkey "$terminfo[kcuu1]" history-substring-search-up
      fi
      if [[ -n "$terminfo[kcud1]" ]]; then
        bindkey "$terminfo[kcud1]" history-substring-search-down
      fi

      # For iTerm2 running on Apple MacBook laptops
      if [[ -n "$terminfo[cuu1]" ]]; then
        bindkey "$terminfo[cuu1]" history-substring-search-up
      fi
      if [[ -n "$terminfo[cud1]" ]]; then
        bindkey "$terminfo[cud1]" history-substring-search-down
      fi

      # For Ubuntu 12.04, Fedora 21, and MacOSX 10.9
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      # For Emacs mode
      bindkey -M emacs '^P' history-substring-search-up
      bindkey -M emacs '^N' history-substring-search-down

      # For VI mode
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down
    fi








# 9 Zsh Syntax Highlighting {{{1                       :zsh-syntax-highlighting:
# ==============================


    # Source:
    # https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/highlighters/main/main-highlighter.zsh
    #
    #: ${ZSH_HIGHLIGHT_STYLES[default]:=none}
    #: ${ZSH_HIGHLIGHT_STYLES[unknown-token]:=fg=red,bold}
    #: ${ZSH_HIGHLIGHT_STYLES[reserved-word]:=fg=yellow}
    #: ${ZSH_HIGHLIGHT_STYLES[alias]:=fg=green}
    #: ${ZSH_HIGHLIGHT_STYLES[suffix-alias]:=fg=green,underline}
    #: ${ZSH_HIGHLIGHT_STYLES[builtin]:=fg=green}
    #: ${ZSH_HIGHLIGHT_STYLES[function]:=fg=green}
    #: ${ZSH_HIGHLIGHT_STYLES[command]:=fg=green}
    #: ${ZSH_HIGHLIGHT_STYLES[precommand]:=fg=green,underline}
    #: ${ZSH_HIGHLIGHT_STYLES[commandseparator]:=none}
    #: ${ZSH_HIGHLIGHT_STYLES[hashed-command]:=fg=green}
    #: ${ZSH_HIGHLIGHT_STYLES[path]:=underline}
    #: ${ZSH_HIGHLIGHT_STYLES[path_prefix]:=underline}
    #: ${ZSH_HIGHLIGHT_STYLES[globbing]:=fg=blue}
    #: ${ZSH_HIGHLIGHT_STYLES[history-expansion]:=fg=blue}
    #: ${ZSH_HIGHLIGHT_STYLES[single-hyphen-option]:=none}
    #: ${ZSH_HIGHLIGHT_STYLES[double-hyphen-option]:=none}
    #: ${ZSH_HIGHLIGHT_STYLES[back-quoted-argument]:=none}
    #: ${ZSH_HIGHLIGHT_STYLES[single-quoted-argument]:=fg=yellow}
    #: ${ZSH_HIGHLIGHT_STYLES[double-quoted-argument]:=fg=yellow}
    #: ${ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]:=fg=yellow}
    #: ${ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]:=fg=cyan}
    #: ${ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]:=fg=cyan}
    #: ${ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]:=fg=cyan}
    #: ${ZSH_HIGHLIGHT_STYLES[assign]:=none}
    #: ${ZSH_HIGHLIGHT_STYLES[redirection]:=none}
    #: ${ZSH_HIGHLIGHT_STYLES[comment]:=fg=black,bold}

    if zplug check zsh-users/zsh-syntax-highlighting; then
      ZSH_HIGHLIGHT_STYLES[default]='none'
      ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
      ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
      ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
      ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,underline'
      ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
      ZSH_HIGHLIGHT_STYLES[function]='fg=magenta'
      ZSH_HIGHLIGHT_STYLES[command]='fg=green'
      ZSH_HIGHLIGHT_STYLES[precommand]='fg=white,underline'
      ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
      ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
      ZSH_HIGHLIGHT_STYLES[path]='fg=blue,bold'
      ZSH_HIGHLIGHT_STYLES[path_prefix]='underline'
      ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'
      ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=blue'
      ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
      ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta'
      ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
      ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
      ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
      ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow'
      ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
      ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
      ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=cyan'
      ZSH_HIGHLIGHT_STYLES[assign]='none'
      ZSH_HIGHLIGHT_STYLES[redirection]='none'
      ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
    fi

