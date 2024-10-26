# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' max-errors 0
zstyle ':completion:*' prompt 'Found %e errors'
zstyle ':completion:*' substitute 1

sshconfig="$HOME/.ssh/config"
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $sshconfig
zstyle :compinstall filename '$HOME/.zshrc'
fpath=(/usr/local/share/zsh-completions $fpath)

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=6000
SAVEHIST=6000
setopt appendhistory extendedglob nomatch notify promptsubst
setopt completealiases vi zle
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

uname=$(uname)
export CODEHOME="$HOME/code"
export CONFIGSHOME="$HOME/Nextcloud/configs"
SOURCE_ZSH_CONFIG_DIR="$CONFIGSHOME/zsh"
SOURCE_ZSH_CONFIG_FILE="$SOURCE_ZSH_CONFIG_DIR/zshrc.zsh"
ZSH_CONFIG_FILE="$HOME/.zshrc"

source $SOURCE_ZSH_CONFIG_DIR/zsh_helpers.zsh
source $SOURCE_ZSH_CONFIG_DIR/zsh-defer/zsh-defer.plugin.zsh

export EDITOR=/usr/bin/vi
export TERM=xterm

source $SOURCE_ZSH_CONFIG_DIR/paths.zsh

eval "$(direnv hook zsh)"

mkcfglink aws .aws
mkcfglink ngrok .ngrok
mkcfglink gitconfig .gitconfig
mkcfglink gitignore_global .gitignore_global
mkcfglink vim/dot_vim .vim
mkcfglink vim/vimrc .vimrc
mkcfglink vim/gvimrc .gvimrc
mkcfglink tigrc .tigrc
mkcfglink tmux.conf .tmux.conf
mkcfglink tmuxinator .tmuxinator

if [ "$uname" = "Darwin" ] ; then
  mkcfglink hammerspoon .hammerspoon
fi

source $SOURCE_ZSH_CONFIG_DIR/visudo.zsh
source $SOURCE_ZSH_CONFIG_DIR/prompt.zsh
source $SOURCE_ZSH_CONFIG_DIR/aliases.zsh
source $SOURCE_ZSH_CONFIG_DIR/docker.zsh
source $SOURCE_ZSH_CONFIG_DIR/npx_aliases.zsh

zsh-defer source $SOURCE_ZSH_CONFIG_DIR/private.zsh

which keychain > /dev/null
if [ $? -eq 0 ] ; then
  eval `keychain --eval --agents ssh id_ed25519`
fi

# pnpm
export PNPM_HOME="/Users/trodrigues/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

source /Users/trodrigues/.config/broot/launcher/bash/br
