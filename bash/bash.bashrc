#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Turn prompt red for root green for all else
if [ $(id -u) -eq 0 ]; then
	PS1='\[[\e[31m\u\e[39m@\h \e[1;34m\W\e[0;39m]\]\$ '
else
	PS1='\[[\e[32m\u\e[39m@\h \e[1;34m\W\e[0;39m]\]\$ '
fi
PS2='> '
PS3='> '
PS4='+ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
