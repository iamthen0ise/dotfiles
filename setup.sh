#!/usr/bin/env zsh

case "$OSTYPE" in
  darwin*)   os_icon="🍏" ;; 
  linux*)    os_icon="🐧" ;;
  *)         os_icon="👾" ;;
esac

print "Hello, ${os_icon}"

print "Setting up dotfiles..."

print "Creating config dir..."

if [ -n "${ZSH_CONFIG_DIR+1}" ]; then
    export ZSH_CONFIG_DIR=$ZSH_CONFIG_DIR
else
    export ZSH_CONFIG_DIR=~/.zsh-config
fi

mkdir -p $ZSH_CONFIG_DIR

software_to_install=(
    vim
    bat
)

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
        # If the directory already exists, remove it and clone again
        print "Removing existing directory: $repo_name"
        rm -rf "$target_dir"
    fi

    if git clone "$repo" "$target_dir" 2>/dev/null ; then 
        print "Cloned: $repo_name"
    else
        print "Failed to clone: $repo_name"
    fi
done
print "Copy config files..."

cp .zsh-config/*.zsh $ZSH_CONFIG_DIR/.
cp .zsh-config/dircolors $ZSH_CONFIG_DIR/.
cat .zshrc > ~/.zshrc

cat .tmux.conf > ~/.tmux.conf

print "All Done! Sourcing ~./zshrc"
source ~/.zshrc
