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
for repo in $repos; do
    if ! git clone $repo $ZSH_CONFIG_DIR/. 2>/dev/null ; then 
        continue
    fi
done

print "Copy config files..."

cp .zsh-config/*.zsh $ZSH_CONFIG_DIR/.
cp .zsh-config/dircolors $ZSH_CONFIG_DIR/.
cat .zshrc > ~/.zshrc

cat .tmux.cinf > ~/.tmux.conf

print "All Done! Sourcing ~./zshrc"
source ~/.zshrc
