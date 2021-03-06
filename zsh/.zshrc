# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode git python sudo systemd)

source $ZSH/oh-my-zsh.sh
source $HOME/.config/zsh-abbrev-alias/abbrev-alias.plugin.zsh

# User configuration

export PATH=/usr/local/bin:$HOME/.bin:$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export EDITOR=nvim
export TERM="xterm-256color"

fpath+=~/.zfunc
compinit -U

# git settings
abbrev-alias gl='git log --graph --all --oneline --decorate'
abbrev-alias gpo='git push origin'

# Rust(lang) Settings
source $HOME/.cargo/env
export LD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=$(rustc --print sysroot)/lib:$DYLD_LIBRARY_PATH
# Use sccache
if command -v sccache 2>&1 >/dev/null ; then
  export RUSTC_WRAPPER=sccache
fi

# exa is a ls replacement written in Rust
abbrev-alias ls='exa'
abbrev-alias lsa='exa -a'
abbrev-alias ll='exa -bghHliS'
abbrev-alias lla='exa -bghaHliS'
abbrev-alias tree='exa -T'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## BROOT
source /home/kevin/.config/broot/launcher/bash/br

# ZLE and broot don't play nicely so we launch `alacritty` and communicate with
# it over a temp file to get broot's output
addbr() {
  tmp_file=$(mktemp) # We'll use this file to communicate with the alacritty process
  cwd=$(pwd)
  alacritty -e /bin/sh -c "cd ${cwd} && broot -o ${tmp_file}"
  broot_out=$(< ${tmp_file} && rm ${tmp_file})
  RBUFFER=${broot_out}${RBUFFER}
}
zle -N addbr
bindkey '^B' addbr # Bind functionality to Ctrl-B

# NAVI

_call_navi() {
  local selected
  if selected="$(printf "$(navi --print --path ${HOME}/Projects/navi-cheats/cheats:${HOME}/Projects/bsi-navi-cheats </dev/tty)")"; then
    LBUFFER="$selected"
  fi
  zle redisplay
}

zle -N _call_navi
bindkey '^n' _call_navi

## PYTHON

# pipx completions
eval "$(register-python-argcomplete pipx)"
# pipx Created by `userpath` on 2021-01-26 15:11:28
export PATH="$PATH:/mnt/storage/home/.local/bin"

# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# virtualenvwrapper
source ~/.local/bin/virtualenvwrapper.sh
alias j=just
alias magit='emacsclient -a emacs -e "(magit-status)"'

## SHELL Prompts

# Starship
#eval "$(starship init zsh)"

# PowerShell10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
