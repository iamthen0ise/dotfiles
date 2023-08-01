#!/usr/bin/env zsh

case "$OSTYPE" in
  darwin*)   
    os_icon="🍏"
    install_cmd="brew install"
    ;; 
  linux*)    
    os_icon="🐧"
    install_cmd="sudo apt install -y"
    ;;
  *)         
    os_icon="👾"
    print "Unsupported OS type, aborting setup..."
    exit 1
    ;;
esac

print "Hello, ${os_icon}"
print "Setting up dotfiles..."
print "Creating config dir..."

export ZSH_CONFIG_DIR=${ZSH_CONFIG_DIR:-~/.zsh-config}
mkdir -p $ZSH_CONFIG_DIR

software_to_install=(
    vim
    bat
    zsh
    jq
    tmux
)

printf 'Installing Software: %s \n' "${software_to_install[@]}"
for software in "${software_to_install[@]}"; do
    $install_cmd $software
done

repos=(
    'git@github.com:mafredri/zsh-async.git'
    'git@github.com:unixorn/fzf-zsh-plugin.git'
    'git@github.com:zsh-users/zsh-syntax-highlighting.git'
    'git@github.com:zsh-users/zsh-history-substring-search.git'
)

printf 'Installing Zsh Plugins: %s \n' "${repos[@]}"
for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" ".git")
    target_dir="$ZSH_CONFIG_DIR/$repo_name"
    
    if [ -d "$target_dir" ]; then
        # If the directory already exists, pull changes
        print "Pulling updates for: $repo_name"
        git -C "$target_dir" pull || print "Failed to update: $repo_name"
    else
        # Clone repository if it doesn't exist
        if git clone "$repo" "$target_dir" 2>/dev/null ; then 
            print "Cloned: $repo_name"
        else
            print "Failed to clone: $repo_name"
        fi
    fi
done

print "Copy config files..."
cp .zsh-config/*.zsh $ZSH_CONFIG_DIR/.
cp .zsh-config/dircolors $ZSH_CONFIG_DIR/.
cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf

print "All Done! Sourcing ~./zshrc"
source ~/.zshrc
