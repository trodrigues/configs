alias showzshrefcard="echo http://www.bash2zsh.com/zsh_refcard/refcard.pdf && echo https://github.com/robbyrussell/oh-my-zsh/tree/master/lib"

mkcfglink() {
  if [ ! -h $HOME/$2 ] ; then
    ln -s $CONFIGSHOME/$1 $HOME/$2
    if [ $? -gt 0 ] ; then
      echo "Failed linking $1 to $2"
    fi
  fi
}

# reloadzshrc() {
#     echo "reloading from cloud"
#     rm -f $ZSH_CONFIG_FILE
#     ln -s $SOURCE_ZSH_CONFIG_FILE $ZSH_CONFIG_FILE
#     source $ZSH_CONFIG_FILE
# }

# editzshrc() {
#     if [ "$1" != "" ] ; then
#         echo "What do you want to edit ?"
#         echo "0) Just open the directory in macvim"
#         echo ""
#         echo "1) Main config file"
#         echo "2) Aliases"
#         echo "3) Zsh helpers"
#         echo "4) Darwin configs"
#         echo "5) Linux configs"
#         read action
#     else
#         action=$1
#     fi

#     case "$action" in
#         0) mvim $SOURCE_ZSH_CONFIG_DIR ;;
#         1) vim $SOURCE_ZSH_CONFIG_FILE ;;
#         2) vim $SOURCE_ZSH_CONFIG_DIR/aliases.zsh ;;
#         3) vim $SOURCE_ZSH_CONFIG_DIR/zsh_helpers.zsh ;;
#         4) vim $SOURCE_ZSH_CONFIG_DIR/darwin_configs.zsh ;;
#         5) vim $SOURCE_ZSH_CONFIG_DIR/linux_configs.zsh ;;
#     esac

#     reloadzshrc
# }

editsshconfig() {
    vim $CONFIGSHOME/sshconfig
    cp $CONFIGSHOME/sshconfig $HOME/.ssh/config
    echo "ssh config reloaded"
}

function clear-scrollback-buffer {
  # Behavior of clear:
  # 1. clear scrollback if E3 cap is supported (terminal, platform specific)
  # 2. then clear visible screen
  # For some terminal 'e[3J' need to be sent explicitly to clear scrollback
  clear && printf '\e[3J'
  # .reset-prompt: bypass the zsh-syntax-highlighting wrapper
  # https://github.com/sorin-ionescu/prezto/issues/1026
  # https://github.com/zsh-users/zsh-autosuggestions/issues/107#issuecomment-183824034
  # -R: redisplay the prompt to avoid old prompts being eaten up
  # https://github.com/Powerlevel9k/powerlevel9k/pull/1176#discussion_r299303453
  zle && zle .reset-prompt && zle -R
}

zle -N clear-scrollback-buffer
