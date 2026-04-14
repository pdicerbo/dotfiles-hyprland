#
# ~/.bash_profile
#
export PATH=$PATH:$HOME/.scripts:$HOME/.local/bin:$HOME/.local/go/bin
export npm_config_prefix="$HOME/.local"

[[ -f ~/.bashrc ]] && . ~/.bashrc

# decomment following lines to enable auto startx
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx # >& MyXLog
fi
