#!/bin/zsh
# COPYRIGHT https://github.com/Phantas0s/.dotfiles/blob/master/zsh/zshenv

source $ZSH_CONFIG_DIR/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh

ff() {
    local branches=$(git branch --all | grep -v HEAD) &&
        local branch=$(echo "$branches" |
            fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

ll() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
            --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
