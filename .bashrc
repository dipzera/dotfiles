#!/bin/bash

# env variables
export USER="${USER:-$(whoami)}"
export GITUSER="$USER"
export REPOS="$HOME/Repos"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"
export WIN="/mnt/c/users/vladg"

export BRAINBOX="$GHREPOS/brainbox"

export SNIPPETS="$DOTFILES/snippets"
export HELP_BROWSER=lynx
export DESKTOP="$WIN/Desktop"
export DOCUMENTS="$WIN/Documents"
export DOWNLOADS="$WIN/Downloads"
export PICTURES="$WIN/Pictures"
export VIDEOS="$WIN/Videos"
export TERM=xterm-256color
export EDITOR=vi
export VISUAL=vi
export EDITOR_PREFIX=vi
export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOPATH:$GOBIN:$GOROOT/bin:$PATH

export PATH=$HOME/.local/bin:$PATH

# aliases
alias todo='vi ~/.todo'
alias ip='ip -c'
alias '?'=gpt
alias '??'=google

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias dotfiles="cd $DOTFILES"
alias scripts="cd $SCRIPTS"
alias brainbox="cd $BRAINBOX"
alias bb=brainbox
alias win="cd $WIN"
alias ala="vi /mnt/c/users/vladg/AppData/Roaming/alacritty/alacritty.yml"
alias wez="vi /mnt/c/users/vladg/.wezterm.lua"
alias python=python3
alias chmox='chmod +x'

alias vi=nvim && EDITOR=nvim

alias github="cd $REPOS/github.com"
alias gitlab="cd $REPOS/gitlab.com"

alias vpn=openvpn3

alias neofetch=fastfetch

alias leto_prod="ssh -i ~/Repos/gitlab.com/polyteia/scripts/ssh_key_file ubuntu@80.158.51.51"

alias azurite="docker run -p 10000:10000 -p 10001:10001 -p 10002:10002 mcr.microsoft.com/azure-storage/azurite"

alias swaycfg="vi ~/.config/sway/config"

alias displays="wdisplays"

alias fish="asciiquarium"

alias ci="gitlab-ci-local"

set -o vi
source /etc/profile.d/bash_completion.sh

PATH="${PATH:+${PATH}:}"$SCRIPTS":/opt/nvim-linux64/bin/nvim"

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# runs tmux on start-up
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux new-session -A -s main
# fi

# init zoxide
eval "$(zoxide init bash)"

# Substitute BIN for your bin directory.
# Substitute VERSION for the current released version.
BIN="/usr/local/bin" &&
  VERSION="1.42.0" &&
  curl -s \
    "https://github.com/bufbuild/buf/releases/download/v${VERSION}/buf-$(uname -s)-$(uname -m)" \
    -o "${BIN}/buf" &&
  chmod +x "${BIN}/buf"

# --------------------------- smart prompt ---------------------------
#                 (keeping in bashrc for portability)
#                 stolen from Rob

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
  local P='$' dir="${PWD##*/}" B countme short long double \
    r='\[\e[31m\]' h='\[\e[34m\]' \
    u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
    b='\[\e[36m\]' x='\[\e[0m\]' \
    g="\[\033[38;2;90;82;76m\]"

  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'

  B=$(git branch --show-current 2>/dev/null)
  [[ $dir = "$B" ]] && B=.
  countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

  [[ $B == master || $B == main ]] && b="$r"
  [[ -n "$B" ]] && B="$g($b$B$g)"

  short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
  long="${g}╔$u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n${g}╚$p$P$x "
  double="${g}╔$u\u$g$PROMPT_AT$h\h$g:$w$dir\n${g}║$B\n${g}╚$p$P$x "

  if ((${#countme} > PROMPT_MAX)); then
    PS1="$double"
  elif ((${#countme} > PROMPT_LONG)); then
    PS1="$long"
  else
    PS1="$short"
  fi
}

PROMPT_COMMAND="__ps1"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export OPENAI_API_KEY=$(<~/.config/gpt/key)
export SRC_ACCESS_TOKEN=$(<~/.config/sourcegraph/token)
export SRC_ENDPOINT='https://sourcegraph.com/'

export DEEPSEEK_API_KEY=$(<~/.config/deepseek/key)
alias ai="aider --model deepseek --api-key deepseek=$DEEPSEEK_API_KEY --no-auto-commits --no-dirty-commits"

export ANTHROPIC_API_KEY=$(<~/.config/anthropic/key)

export SUPERSET_CONFIG_PATH="$REPOS/gitlab.com/polyteia/polyteia-analytics/superset_config.py"

PATH="/home/vladgorea/perl5/bin${PATH:+:${PATH}}"
export PATH
PERL5LIB="/home/vladgorea/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL5LIB
PERL_LOCAL_LIB_ROOT="/home/vladgorea/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_LOCAL_LIB_ROOT
PERL_MB_OPT="--install_base \"/home/vladgorea/perl5\""
export PERL_MB_OPT
PERL_MM_OPT="INSTALL_BASE=/home/vladgorea/perl5"
export PERL_MM_OPT
export PATH="$PATH:/home/vladgorea/sqlpackage"

# Azure
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

# Gnome workspaces
# gsettings set org.gnome.mutter dynamic-workspaces false
# gsettings set org.gnome.desktop.wm.preferences num-workspaces 9
# for i in {1..9}
# do
#   gsettings set "org.gnome.shell.keybindings" "switch-to-application-$i" "[]"
#   gsettings set "org.gnome.desktop.wm.keybindings" "switch-to-workspace-$i" "['<Super>${i}']"
#   gsettings set "org.gnome.desktop.wm.keybindings" "move-to-workspace-$i" "['<Super><Shift>${i}']"
# done
#
#
#
# opencode
export PATH=/home/vladgorea/.opencode/bin:$PATH
