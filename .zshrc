#!/usr/bin/env zsh

# Mount plugin directory
if [ -n "${ZSH_CONFIG_DIR+1}" ]; then
    export ZSH_CONFIG_DIR=$ZSH_CONFIG_DIR
else
    export ZSH_CONFIG_DIR=~/.zsh-config
fi

# Source ZSH plugins
for file in $ZSH_CONFIG_DIR/*.zsh; do
    source "$file"
done

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
