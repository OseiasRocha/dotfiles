# Environment shared by login shells.
if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Interactive login shells (including tmux) also need aliases and the prompt.
if [[ $- == *i* ]] && [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
. "$HOME/.cargo/env"
