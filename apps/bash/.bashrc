# .bashrc

# Shell customizations below apply only to interactive shells.
case $- in
    *i*) ;;
    *) return ;;
esac

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

for completion_file in "$HOME/repos/alacritty/extra/completions/alacritty.bash" \
    "$HOME/.local/share/bash-completion/completions/deno.bash"; do
    if [ -f "$completion_file" ]; then
        . "$completion_file"
    fi
done
unset completion_file

if [[ -f ~/repos/emsdk/emsdk_env.sh ]]; then
    EMSDK_QUIET=1 source ~/repos/emsdk/emsdk_env.sh
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

