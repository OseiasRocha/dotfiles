export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/mise/shims:$PATH"

. "$HOME/.cargo/env"
. "$HOME/.deno/env"
. "$HOME/.local/share/bash-completion/completions/deno.bash"

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
