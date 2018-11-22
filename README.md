# dotfiles

> Linux config files (beets, cmus, dunst, git, GnuPG, i3, mpv, ranger, rofi,
> sxhkd, X11, zsh)

```text
                   dP            dP   .8888b oo dP
                   88            88   88   "    88
             .d888b88 .d8888b. d8888P 88aaa  dP 88 .d8888b. .d8888b.
             88'  `88 88'  `88   88   88     88 88 88ooood8 Y8ooooo.
             88.  .88 88.  .88   88   88     88 88 88.  ...       88
.----------- `88888P8 `88888P'   dP   dP     dP dP `88888P' `88888P' ----------.
|:::::::::::::.......::......::::..:::..:::::..:..::......:::......::::::::::::|
|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::|
|::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::|
|------------------------------------------------------------------------------|
|    beets | music tagger & library organizer                          beet(1) |
|     cmus | c* music player                                           cmus(1) |
|    dunst | notification daemon                                      dunst(1) |
|      git | revision control system                                    git(1) |
|    gnupg | gnu privacy guard suite         gpg2(1), gpg-agent(1), dirmngr(8) |
|       i3 | window manager                                              i3(1) |
| i3blocks | flexible scheduler for i3bar                          i3blocks(1) |
|     inox | chromium browser (inox-patchset)              chromium-browser(1) |
|      mpv | media player                                               mpv(1) |
|   ranger | file manager                                            ranger(1) |
|     rofi | run launcher, window switcher, etc.                       rofi(1) |
|    sxhkd | simple x hotkey daemon                                   sxhkd(1) |
|      x11 | x window system                        x(7), xinit(1), xserver(1) |
|      zsh | z shell                                                 zshall(1) |
`------------------------------------------------------------------------------'
```

## Quickstart

1.  Clone the repository into your home directory:

    `git clone --recurse-submodules --jobs 4 https://github.com/bardisty/dotfiles ~/dotfiles`

2.  `cd` into the repository:

    `cd ~/dotfiles`

3.  Use [GNU Stow](https://www.gnu.org/software/stow/) to create and manage
    the required symlinks:

    `stow <directory>` e.g., `stow mpv`

## Stow

[Stow](https://www.gnu.org/software/stow/) can be installed with your
package manager, or you can [build it from source](https://savannah.gnu.org/git/?group=stow).

By default, [Stow](https://www.gnu.org/software/stow/) will create symlinks
in the parent directory of the current working directory. If your current
working directory is `~/dotfiles` and you run `stow mpv`, the following
symlinks will be created:

```text
~/.config/mpv/scripts => ../../dotfiles/mpv/.config/mpv/scripts
~/.config/mpv/shaders => ../../dotfiles/mpv/.config/mpv/shaders
~/.config/mpv/input.conf => ../../dotfiles/mpv/.config/mpv/input.conf
~/.config/mpv/mpv.conf => ../../dotfiles/mpv/.config/mpv/mpv.conf
```

Stow doesn't print anything when a command succeeds. To see
what's going on behind the scenes, pass in the verbose option (`-v`):

`stow -v mpv`

```text
$ stow -v mpv
LINK: .config/mpv/scripts => ../../dotfiles/mpv/.config/mpv/scripts
LINK: .config/mpv/shaders => ../../dotfiles/mpv/.config/mpv/shaders
LINK: .config/mpv/input.conf => ../../dotfiles/mpv/.config/mpv/input.conf
LINK: .config/mpv/mpv.conf => ../../dotfiles/mpv/.config/mpv/mpv.conf
```

### Delete

To delete any symlinks created by Stow, pass in the *delete* option (`-D`):

`stow -D mpv`

```text
$ stow -v -D mpv
UNLINK: .config/mpv/scripts
UNLINK: .config/mpv/shaders
UNLINK: .config/mpv/input.conf
UNLINK: .config/mpv/mpv.conf
```

### Restow

If new files or folders are added and need to be symlinked, or if obsolete
symlinks in the target tree need to be pruned, pass in the *restow* option
(`-R`):

`stow -R mpv`

```text
$ stow -v -R mpv
UNLINK: .config/mpv/scripts
UNLINK: .config/mpv/shaders
UNLINK: .config/mpv/input.conf
UNLINK: .config/mpv/mpv.conf
LINK: .config/mpv/scripts => ../../dotfiles/mpv/.config/mpv/scripts (reverts previous action)
LINK: .config/mpv/shaders => ../../dotfiles/mpv/.config/mpv/shaders (reverts previous action)
LINK: .config/mpv/input.conf => ../../dotfiles/mpv/.config/mpv/input.conf (reverts previous action)
LINK: .config/mpv/mpv.conf => ../../dotfiles/mpv/.config/mpv/mpv.conf (reverts previous action)
LINK: .config/mpv/some-new-dir => ../../dotfiles/mpv/.config/mpv/some-new-dir
```

### Target

Stow's default target directory is the parent of the current working
directory. To change the target directory, pass in the *target* option
(`-t`).

E.g., to install Zsh configs for the root user:

`sudo stow -t /root zsh`

```text
$ sudo stow -v -t /root zsh
LINK: .zsh.d => ../home/bah/dotfiles/zsh/.zsh.d
LINK: .zprofile => ../home/bah/dotfiles/zsh/.zprofile
LINK: .zshrc => ../home/bah/dotfiles/zsh/.zshrc
LINK: .zshenv => ../home/bah/dotfiles/zsh/.zshenv
```

To delete the symlinks created in `/root`, pass in the *delete* option
(`-D`) as well as the *target* option (`-t`):

`sudo stow -t /root -D zsh`

```text
$ sudo stow -v -t /root -D zsh
UNLINK: .zsh.d
UNLINK: .zprofile
UNLINK: .zshrc
UNLINK: .zshenv
```

### More info

For more information on Stow, see `stow -h`, `man stow`, or `info stow`.
