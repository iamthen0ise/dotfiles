# iTerm2 tab color commands
# https://iterm2.com/documentation-escape-codes.html

if [[ -n "$ITERM_SESSION_ID" ]]; then
    tab-color() {
        echo -ne "\033]6;1;bg;red;brightness;$1\a"
        echo -ne "\033]6;1;bg;green;brightness;$2\a"
        echo -ne "\033]6;1;bg;blue;brightness;$3\a"
    }
    tab-reset() { echo -ne "\033]6;1;bg;*;default\a" }

    function iterm2_tab_precmd() {
        tab-reset
    }

    function iterm2_tab_preexec() {
        if [[ "$1" =~ "^ssh " ]]; then
            tab-color 255 0 0
        fi
        
        if [[ "$1" =~ "^docker" ]] || [[ "$1" =~ "dc" ]]; then
            tab-color 0 0 255
        fi
    }

    autoload -U add-zsh-hook
    add-zsh-hook precmd  iterm2_tab_precmd
    add-zsh-hook preexec iterm2_tab_preexec
fi
