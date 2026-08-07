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

alias ls='ls --color=auto'
alias ll='ls -alF --color=auto'
alias la='ls -lha --color=auto'

. "/home/ozzy/repos/alacritty/extra/completions/alacritty.bash"
. "/home/ozzy/.local/share/bash-completion/completions/deno.bash"

echo "test"

eval "$(starship init bash)"
