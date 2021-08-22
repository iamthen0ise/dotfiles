#!/bin/zsh

if [ -n "${ZSH_CONFIG_DIR+1}" ]; then
    export ZSH_CONFIG_DIR=$ZSH_CONFIG_DIR
else
    export ZSH_CONFIG_DIR=~/.zsh-config
fi

mkdir -p $ZSH_CONFIG_DIR

git clone git@github.com:zsh-users/zsh-history-substring-search.git $ZSH_CONFIG_DIR/zsh-history-substring-search
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git $ZSH_CONFIG_DIR/zsh-syntax-highlighting
git clone git@github.com:mafredri/zsh-async.git $ZSH_CONFIG_DIR/zsh-async
git clone git@github.com:unixorn/fzf-zsh-plugin.git $ZSH_CONFIG_DIR/fzf-zsh-plugin

cp zsh-config/*.zsh $ZSH_CONFIG_DIR/.
cat .zshrc > ~/.zshrc

source ~/.zshrc
