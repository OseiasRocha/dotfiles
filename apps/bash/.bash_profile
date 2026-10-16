export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/mise/shims:$PATH"

. "$HOME/.cargo/env"
if [ -d "$HOME/.deno" ]; then
    . "$HOME/.deno/env"
    . "$HOME/.local/share/bash-completion/completions/deno.bash"
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
