#                                               .8888b oo dP
#                                               88   "    88
#           d888888b 88d888b. 88d888b. .d8888b. 88aaa  dP 88 .d8888b.
#              .d8P' 88'  `88 88'  `88 88'  `88 88     88 88 88ooood8
#            .Y8P    88.  .88 88       88.  .88 88     88 88 88.  ...
# .-------- d888888P 88Y888P' dP       `88888P' dP     dP dP `88888P' ---------.
# |:::::::::........:88 ....::..::::::::......::..:::::..:..::......:::::::::::|
# |::::::::::::::::::dP :::::::::::::::::::::::::::::::::::::::::::::::::::::::|
# |::::::::::::::::::..::::::::::::::::::::::::::::::::::::::::::::::::::::::::|
# |----------------------------------------------------------------------------|
# |     file | ~/.zprofile                                                     |
# |     desc | Execute commands when Zsh is started as a login shell           |
# |   author | bardisty <b@bah.im>                                             |
# |   source | https://github.com/bardisty/dotfiles                            |
# | modified | Fri Aug 19 2016 11:35:09 PDT -0700                              |
# `----------------------------------------------------------------------------'


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

# Setup $PATH
PATH_SCRIPT="${HOME}/.path"
[ -x "$PATH_SCRIPT" ] && . "$PATH_SCRIPT"

