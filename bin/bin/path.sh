#!/usr/bin/env sh
#
#                                            dP   dP
#                                            88   88
#                        88d888b. .d8888b. d8888P 88d888b.
#                        88'  `88 88'  `88   88   88'  `88
#                        88.  .88 88.  .88   88   88    88
# ╔═════════════════════ 88Y888P' `88888P8   dP   dP    dP ════════════════════╗
# ║::::::::::::::::::::::88 ....:::.......:::..:::..::::..:::::::::::::::::::::║
# ║::::::::::::::::::::::dP :::::::::::::::::::::::::::::::::::::::::::::::::::║
# ║::::::::::::::::::::::..::::::::::::::::::::::::::::::::::::::::::::::::::::║
# ╠════════════════════════════════════════════════════════════════════════════╣
# ║     file │ ~/bin/path.sh                                                   ║
# ║     desc │ Build the PATH environment variable                             ║
# ║   author │ bardisty <b@bah.im>                                             ║
# ║   source │ https://github.com/bardisty/dotfiles                            ║
# ║ modified │ Thu Aug 25 2016 10:47:35 PDT -0700                              ║
# ╚════════════════════════════════════════════════════════════════════════════╝


# Usually sourced in:
#     * ~/.xinitrc........for use with X sessions⁽¹⁾
#     * ~/.zprofile.......for use with Zsh login shells⁽¹⁾
#     * ~/.zshenv.........for use with Zsh shell / everything else
#
# 1. Normally, the path should be set in `~/.zshenv`, but Arch Linux
#    sources `/etc/profile` after sourcing `~/.zshenv`
#
#    Source order:
#       Login shell:
#           ~/.zshenv -> /etc/profile -> ~/.zprofile
#       X Session:
#           ~/.zshenv -> /etc/profile -> ~/.xinitrc (X initialized) -> ~/.zshenv (e.g., terminal opened)
#
#    To prevent the $PATH from being overwritten...
#       * ...in a login shell, set it in `~/.zprofile`
#       * ...at the start of an X session, set it in `~/.xinitrc`
#
#    https://wiki.archlinux.org/index.php/Zsh#Configuring_.24PATH


# Check if a path already exists in the $PATH
exists_in_path() {
  printenv PATH | grep -q "$1"
}


# Add Go `GOPATH` bin directory to $PATH if:
#     * `GOPATH` environment variable has been defined
#     * `${GOPATH}/bin` directory exists
#     * `${GOPATH}/bin` does not already exist in the $PATH
if [ -n "$GOPATH" ] && [ -d "${GOPATH}/bin" ]; then
  if ! exists_in_path "${GOPATH}/bin"; then
    export PATH="${PATH}:${GOPATH}/bin"
  fi
fi


# Add `~/bin` to $PATH if:
#     * Current user ID is greater than or equal to 1000
#     * `~/bin` directory exists
#     * `~/bin` does not already exist in the $PATH
if [ "$(id -u)" -ge 1000 ] && [ -d "${HOME}/bin" ]; then
  if ! exists_in_path "${HOME}/bin"; then
    export PATH="${PATH}:${HOME}/bin"
  fi
fi


# Add current Ruby version to $PATH if:
#     * Ruby bin directory exists
#     * Ruby bin directory does not already exist in the $PATH
RUBY_BIN="${HOME}/.gem/ruby/2.3.0/bin"
if [ -d "$RUBY_BIN" ]; then
  if ! exists_in_path "$RUBY_BIN"; then
    export PATH="${PATH}:${RUBY_BIN}"
  fi
fi

