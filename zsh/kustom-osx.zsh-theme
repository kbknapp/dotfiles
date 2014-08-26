##
# Kustom ZSH Theme
# Author - Kevin K. <kbknapp@gmail.com>
# Version 0.3
##

ZSH_THEME_GIT_PROMPT_PREFIX="[git: "
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
ZSH_THEME_RC="%{$reset_color%}"
function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    local GIT_PROMPT="$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
    if [[ $(parse_git_dirty) = $ZSH_THEME_GIT_PROMPT_DIRTY ]]; then
		echo "$ZSH_THEME_GIT_PROMPT_DIRTY 𝙓 $GIT_PROMPT"
	else
		echo "$ZSH_THEME_GIT_PROMPT_CLEAN ✓ $GIT_PROMPT"
	fi
}

function get_pwd() {
    echo "${PWD/$HOME/~}"
}

function get_user_color() {
    if [ $UID -eq 0 ]; then
        echo "%{$fg[red]%}"
    else
        echo "%{$fg[green]%}"
    fi
}

# Example:
# 
# kevin@host: ~/Projects 						x [git: master]
# ➜
PROMPT='
$(get_user_color)%n$ZSH_THEME_RC@%{$fg[blue]%}%m$ZSH_THEME_RC: %{$fg[yellow]%}$(get_pwd)$ZSH_THEME_RC 
$(get_user_color)➜$ZSH_THEME_RC '
RPROMPT='$(git_prompt_info)$ZSH_THEME_RC'
