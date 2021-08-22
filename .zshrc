#!/bin/zsh

if [ -n "${ZSH_CONFIG_DIR+1}" ]; then
    export ZSH_CONFIG_DIR=$ZSH_CONFIG_DIR
else
    export ZSH_CONFIG_DIR=~/.zsh-config
fi

# Source ZSH Plugins
for file in $ZSH_CONFIG_DIR/*.zsh; do
    source "$file"
done

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
