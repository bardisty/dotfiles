# prompt style and colors based on Steve Losh's Prose theme:
# http://github.com/sjl/oh-my-zsh/blob/master/themes/prose.zsh-theme
#
# vcs_info modifications from Bart Trojanowski's zsh prompt:
# http://www.jukie.net/bart/blog/pimping-out-zsh-prompt
#
# git untracked files modification from Brian Carper:
# http://briancarper.net/blog/570/git-info-in-your-zsh-prompt
#
# modified by bardisty:
# https://github.com/bardisty/dotfiles

export VIRTUAL_ENV_DISABLE_PROMPT=1

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('$fg[blue]`basename $VIRTUAL_ENV`%{$reset_color%}') '
}
PR_GIT_UPDATE=1

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

cyan="$fg[cyan]"
yellow="$fg[yellow]"
magenta="$fg[magenta]"
red="$fg[red]"
green="$fg[green]"
gray="$fg[white]"

# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%{${reset_color}%}"
FMT_BRANCH="(%{$cyan%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$green%}%a${PR_RST})"
FMT_UNSTAGED="%{$yellow%}◆"
FMT_STAGED="%{$green%}◆"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function steeef_preexec {
    case "$(history $HISTCMD)" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec steeef_preexec

function steeef_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd steeef_chpwd

function steeef_precmd {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="(%{$cyan%}%b%u%c%{$red%}◆${PR_RST})"
        else
            FMT_BRANCH="(%{$cyan%}%b%u%c${PR_RST})"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd


# SSH detection as root user requires
# `Defaults env_keep += "SSH_CONNECTION SSH_CLIENT SSH_TTY"`
# via `visudo`
if (( $+SSH_CONNECTION )); then
  if [[ $UID == 0 || $EUID == 0 ]]; then
# if connected to SSH as root user
PROMPT=$'
%{$gray%}┌──╼ %{$red%}%n@%M %{$gray%}╾─╼ %~%{$reset_color%} $vcs_info_msg_0_$(virtualenv_info)%{$reset_color%}
%{$gray%}└╼%{$reset_color%} '
  else
# if connected to SSH as regular user
PROMPT=$'

%{$gray%}┌──╼ %{$yellow%}%n@%M %{$gray%}╾─╼ %~%{$reset_color%} $vcs_info_msg_0_$(virtualenv_info)%{$reset_color%}
%{$gray%}└╼%{$reset_color%} '
  fi
else
  if [[ $UID == 0 || $EUID == 0 ]]; then
# if not connected to SSH; root user
PROMPT=$'

%{$gray%}┌──╼ %{$red%}%n %{$gray%}╾─╼ %~%{$reset_color%} $vcs_info_msg_0_$(virtualenv_info)%{$reset_color%}
%{$gray%}└╼%{$reset_color%} '
  else
# if not connected to SSH; regular user
PROMPT=$'

%{$gray%}┌──╼ %~%{$reset_color%} $vcs_info_msg_0_$(virtualenv_info)%{$reset_color%}
%{$gray%}└╼%{$reset_color%} '
  fi
fi
