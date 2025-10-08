#
# ~/.bash_profile
#
export PATH=$PATH:$HOME/.scripts:$HOME/.local/bin:$HOME/.local/go/bin

[[ -f ~/.bashrc ]] && . ~/.bashrc

# decomment following lines to enable auto startx
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec Hyprland
fi
