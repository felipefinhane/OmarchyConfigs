#
# ~/.bash_profile - Bash login shell configuration for Omarchy
#

# Source .bashrc if it exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Set PATH to include user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Export environment variables
export EDITOR=vim
export BROWSER=firefox
export TERMINAL=alacritty

# Load local customizations if they exist
[ -f ~/.bash_profile.local ] && source ~/.bash_profile.local