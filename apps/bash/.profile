for env_file in "$HOME/.cargo/env" "$HOME/.deno/env"; do
    if [ -f "$env_file" ]; then
        . "$env_file"
    fi
done
unset env_file
