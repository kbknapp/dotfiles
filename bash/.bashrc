#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias lsg='ls --group-directories-first --color=auto'
alias ls='ls --color=auto'
alias llg='ls -al --group-directories-first --color=auto'
alias ll='ls -al --color=auto'

PS1='\[[\e[32m\u\e[39m@\h \e[1;34m\W\e[0;39m]\]\$ '
	
export GOPATH=$HOME/.go
export GOBIN=$GOPATH/bin
export GOROOT=/opt/go
export PATH=$PATH:$GOBIN:$GOROOT/bin
