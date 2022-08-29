#!/usr/bin/env bash

set -euo pipefail

DEFAULT_AMD_REMOTE=engbox-amd64-us1
DEFAULT_ARM_REMOTE=engbox-amd64-us1

cd ${HOME}/Projects/eng/
just clean

cd ${HOME}/Projects/
fd -td -g target -x rm -rf {} \;

tar czf ${HOME}/projects.tgz

if [[ "$(uname -m)" == "aarch64" ]]; then
  REMOTE=${DEFAULT_AMD_REMOTE}
else
  REMOTE=${DEFAULT_ARM_REMOTE}
fi
lxc launch ubuntu:20.04 ${REMOTE}:$(hostname)-xfer
lxc file push ${HOME}/projects.tgz ${REMOTE}:$(hostname)-xfer/opt/
