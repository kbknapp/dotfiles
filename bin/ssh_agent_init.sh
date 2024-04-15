#!/usr/bin/env bash

# Fix SSH auth socket location so agent forwarding works with tmux
if [ -n "$SSH_AGENT_PID" ]; then
    if ps $SSH_AGENT_PID | grep -q defunct; then
        unset SSH_AGENT_PID
        eval "$(ssh-agent -s)"
    fi
else
    eval "$(ssh-agent -s)"
fi

if [ -e "$SSH_AUTH_SOCK" ] ; then
  if [[ "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock" ]] ; then
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
  fi
fi

if [[ "$(uname)" == "Darwin" ]]; then
    ssh-add --apple-use-keychain "${SSH_KEY_PATH}"
else
    ssh-add "${SSH_KEY_PATH}"
fi

