#!/bin/zsh

setopt prompt_subst

local GIT_PROMPT_PREFIX="%F{$reset_color%}%F{white}"
local GIT_PROMPT_SUFFIX=""
local GIT_PROMPT_DIRTY="%F{red} ● %F{white}%F{reset_color}"
local GIT_PROMPT_CLEAN="%F{reset_color} ● "

local COMMAND_SUCCESS="%F{reset_color}> %F{reset_color}"
local COMMAND_FAIL="%F{red}x %F{reset_color}"

function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2>/dev/null) || return
    echo "$GIT_PROMPT_PREFIX$(parse_git_dirty)$GIT_PROMPT_SUFFIX"
}

parse_git_dirty() {
    ref=$(git symbolic-ref HEAD 2>/dev/null)
    if [[ -n $(git status -s --ignore-submodules=dirty 2>/dev/null) ]]; then
        echo "${ref#refs/heads/}$GIT_PROMPT_DIRTY"
    else
        echo "${ref#refs/heads/}$GIT_PROMPT_CLEAN"
    fi
}

last_cmd() {
    echo "%(?.$COMMAND_SUCCESS.$COMMAND_FAIL)"
}

PROMPT='%2~ $(last_cmd)$(git_prompt_info)'
