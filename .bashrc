#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pacman='pacman --color=auto'
alias diff='diff --color=auto'
alias ncdu='ncdu --color dark'
alias icat="kitten icat"
alias p='python'
alias sshfs_atsapp234='sshfs atsapp234:/srv/projects/ /home/pierluigi/DockerEnvs/sshfs/monitor_stack_atsapp234'
alias sshfs_atsapp235='sshfs atsapp235:/srv/projects/ /home/pierluigi/DockerEnvs/sshfs/srv_prj_atsapp235'
alias sshfs_atsuwk070='sshfs atsuwk070:/srv/projects/EXP.0_BP_DEV/BE/docker_bp_dev_apps/ /home/pierluigi/DockerEnvs/sshfs/dev_atsuwk070'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles-bare-repo --work-tree=$HOME"
alias ssh="kitty +kitten ssh"

# avoid pasting weird characters
bind 'set enable-bracketed-paste off'

# sourcing git-completion.bash
if [ -f /usr/share/git/completion/git-completion.bash ]; then
    source /usr/share/git/completion/git-completion.bash
fi

if [ -f /usr/share/git/completion/git-prompt.sh ]; then
    source /usr/share/git/completion/git-prompt.sh
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true

    PS1='\[\e[;36m\]┌──(\[\e[1;34m\]\u@\h\[\e[;36m\])-[\[\e[;35m\]\w\[\e[;36m\]]\[\e[;36m\]$(__git_ps1 "─[\[\e[1;34m\]%s\[\e[;36m\]]")\n\[\e[;36m\]└─\[\e[1;37m\]>\[\e[0m\] '
    # OS_ICON=󰣇
    # PS1="\n \[\033[0;34m\]╭─\[\033[0;36m\]\[\033[0;30m\]\[\033[46m\] $OS_ICON \u@\h \[\033[0m\]\[\033[0;36m\]\[\033[44m\]\[\033[0;34m\]\[\033[48m\]\[\033[0;30m\]\[\033[44m\] \w \[\033[0m\]\[\033[0;34m\]$(__git_ps1 "─[\[\e[1;34m\]%s\[\e[;36m\]]") \n \[\033[0;34m\]╰ > \[\033[0m\]"

else

    PS1='\[\e[;36m\]┌──(\[\e[1;34m\]\u@\h\[\e[;36m\])-[\[\e[;35m\]\w\[\e[;36m\]]\n\[\e[;36m\]└─\[\e[1;37m\]>\[\e[0m\] '

fi

# setxkbmap -option compose:rwin

export GOPATH=$HOME/.local/go
fastfetch
