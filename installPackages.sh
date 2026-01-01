#!/usr/bin/env bash

. /etc/os-release

if [[ "$ID" == "debian" || "$ID" == "ubuntu" ]]; then

	sudo apt update

	sudo apt upgrade -y

	sudo apt install build-essential clang clangd gdb fzf git ripgrep tmux curl ninja-build gettext cmake unzip python3-venv podman stow file -y
elif [[ "$ID" == "fedora" ]]; then
	echo "Updating distro"
	sudo dnf upgrade -y
	sudo dnf group install development-tools c-development -y
	echo "Installing tools and dependencies"
	sudo dnf install vim tmux ripgrep clangd clang gdb fzf git curl ninja-build gettext cmake unzip python3-pip stow file awk -y
	echo "Installing docker and running hello-world"
	sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
	sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo systemctl enable --now docker
	sudo groupadd docker
	sudo usermod -aG docker $USER
	newgrp docker
	docker run hello-world
	read -p "Press ENTER after checking docker installation"
else
	echo "Unsupported distro"
	exit 1
fi

# install starship prompt
curl -sS https://starship.rs/install.sh | sudo sh

git config --global user.name "Oséias K. Rocha"
git config --global user.email "oseiaskr95@gmail.com"

# creates a github key in case it doesn't exist yet

if [ ! -f "~/.ssh/github_ed25519" ]; then
	# setup git
	ssh-keygen -t ed25519 -C "oseiaskr95@gmail.com" -f ~/.ssh/github_ed25519 -N ""
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/github_ed25519
	echo "Add this key to github"
	cat ~/.ssh/github_ed25519.pub
	echo -e "Host github.com\n\tIdentityFile ~/.ssh/github_ed25519\n\tAddKeysToAgent yes" >> ~/.ssh/config
	read -p "Press ENTER after adding the key to github"
fi

# clones the repo for the dotfiles in case it wasn't already cloned
if [ ! -d "~/Repos/dotfiles" ]; then
	mkdir -p ~/Repos/dotfiles
	git clone --recurse-submodules git@github.com:OseiasRocha/dotfiles.git ~/Repos/dotfiles
elif [ ! -d "~/Repos/dotfiles/.git" ]; then
	echo "Stopping script. Please delete the folder ~/Repos/dotfiles"
	exit 1
fi

# install lazygit
pushd ~/
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install go
GO_VERSION=$(curl -s https://go.dev/dl/ | grep -oP 'go[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1)

# Build download URL
GO_URL="https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz"

# Download Go tarball
curl -LO "$GO_URL"
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ${GO_VERSION}.linux-amd64.tar.gz

popd

# deletes exisiting files to replace with dotfiles from github
for file in ~/Repos/dotfiles/.*; do
    [ -e "$file" ] || continue  # only regular files

    if [ -e "${HOME}/"$(basename "$file")"" ]; then
        rm -rf "${HOME}/"$(basename "$file")""
    fi
done

# configures dotfiles
pushd ~/Repos/dotfiles
stow . -t ~/
popd

source ~/.bashrc

# install tmux plugins
~/Repos/dotfiles/.tmux/plugins/tpm/bin/./install_plugins

sed -i '/@catppuccin_window_text/ s/" #T"/" #W"/' ~/Repos/dotfiles/.tmux/plugins/tmux/catppuccin_options_tmux.conf
sed -i '/@catppuccin_window_current_text / s/" #T"/" #W"/' ~/Repos/dotfiles/.tmux/plugins/tmux/catppuccin_options_tmux.conf
