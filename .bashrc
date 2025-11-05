# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
# Ignore case in TAB completion
bind "set completion-ignore-case on"

# Ignore case in filename globbing
shopt -s nocaseglob

# Ignore case in string comparisons
shopt -s nocasematch

. "$HOME/.cargo/env"
PATH=$PATH:"$HOME/.local/opt/go/bin":"$HOME/go/bin":"$HOME/idea-IC-251.26094.121/bin":"$HOME/.local/bin":"$HOME/zig-x86_64-linux-0.14.1"

eval "$(starship init bash)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
