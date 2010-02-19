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
export CONFIGSHOME="$HOME/Dropbox/configs"

export EDITOR=/usr/bin/vi
export TERM=xterm

#export LANGUAGE=en_GB.UTF-8
#export LC_CTYPE=en_GB.UTF-8
#export LC_ALL=en_GB.UTF-8
#export LANG=en_GB.UTF-8

load_zsh_config(){
    local configfile=$CONFIGSHOME/zsh/$1.zsh
    if [ -f $configfile ] ; then
        source $configfile
    else
        echo "Cannot load $configfile"
    fi
}

load_zsh_config paths

eval "$(direnv hook zsh)"

#export AWS_PROFILE=default
#export AWS_REGION=us-east-1

# exa
#colorarg="-G"

load_zsh_config zsh_helpers

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

load_zsh_config visudo

load_zsh_config prompt
load_zsh_config aliases
load_zsh_config docker
load_zsh_config npx_aliases

load_zsh_config private

which keychain > /dev/null
if [ $? -eq 0 ] ; then
  eval `keychain --eval --agents ssh id_ed25519`
fi

