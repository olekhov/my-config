#!/bin/sh

export PATH=$PATH:~/.local/bin:~/.cargo/bin
export GNUPGHOME=$HOME/mykeychain
export EDITOR=$HOME/.local/bin/nvim

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export _JAVA_AWT_WM_NONREPARENTING=1


