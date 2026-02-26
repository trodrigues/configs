# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="avit"
ZSH_THEME="tkcandy"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="false"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=$HOME/Nextcloud/configs/zsh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    eza
    aliases
    dircycle
    tmux
    vi-mode
    git
    jump
)

export EDITOR=/usr/bin/vi
export TERM=xterm

export CODEHOME="$HOME/code"
export CONFIGSHOME="$HOME/Nextcloud/configs"
export CONFIGSHOME="$HOME/Nextcloud/configs"
SOURCE_ZSH_CONFIG_DIR="$CONFIGSHOME/zsh"
uname=$(uname)

source $SOURCE_ZSH_CONFIG_DIR/paths.zsh
source $SOURCE_ZSH_CONFIG_DIR/aliases.zsh
source $SOURCE_ZSH_CONFIG_DIR/helpers.zsh

source $SOURCE_ZSH_CONFIG_DIR/zsh-defer/zsh-defer.plugin.zsh

# Everything before this line needs to be sourced
# before Oh My Zsh is initialized
source $ZSH/oh-my-zsh.sh

unsetopt share_history

sshconfig="$HOME/.ssh/config"
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $sshconfig

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
mkcfglink ghostty .config/ghostty/config

if [ "$uname" = "Darwin" ] ; then
  mkcfglink hammerspoon .hammerspoon
fi

source $SOURCE_ZSH_CONFIG_DIR/visudo.zsh
source $SOURCE_ZSH_CONFIG_DIR/docker.zsh
source $SOURCE_ZSH_CONFIG_DIR/git.zsh
source $SOURCE_ZSH_CONFIG_DIR/npx_aliases.zsh

zsh-defer source $SOURCE_ZSH_CONFIG_DIR/private.zsh

which keychain > /dev/null
if [ $? -eq 0 ] ; then
  eval `keychain --eval --agents ssh id_ed25519`
fi

if [ "$uname" = "Darwin" ] ; then
    export PNPM_HOME="$HOME/Library/pnpm"
    case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
fi

source $HOME/.config/broot/launcher/bash/br

# EOF user zsh config

# opencode
export PATH=/Users/trodrigues/.opencode/bin:$PATH
