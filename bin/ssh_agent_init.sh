#!/usr/bin/env bash

function start_agent() {
  unset SSH_AGENT_PID
  eval "$(ssh-agent -s)"
  echo "$SSH_AGENT_PID" >$HOME/.local/run/ssh-agent.pid
}

# Fix SSH auth socket location so agent forwarding works with tmux
if [ -n "$SSH_AGENT_PID" ]; then
  if ps -p $SSH_AGENT_PID | grep -q defunct; then
    kill $SSH_AGENT_PID
    start_agent
  fi
elif [ -f "$HOME/.local/run/ssh-agent.pid" ]; then
  if ! ps -p "$(cat $HOME/.local/run/ssh-agent.pid)" >/dev/null; then
    rm $HOME/.local/run/ssh-agent.pid
    start_agent
  fi
else
  start_agent
fi

if [ -e "$SSH_AUTH_SOCK" ]; then
  if [[ "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh_auth_sock" ]]; then
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
  fi
fi

if [[ "$(uname)" == "Darwin" ]]; then
  ssh-add --apple-use-keychain "${SSH_KEY_PATH:-~/.ssh/id_ed25519}"
else
  #ssh-add "${SSH_KEY_PATH:-~/.ssh/id_ed25519}"
fi
