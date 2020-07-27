SOURCE_ZSH_CONFIG_DIR="$CONFIGSHOME/zsh"
SOURCE_ZSH_CONFIG_FILE="$SOURCE_ZSH_CONFIG_DIR/zshrc.zsh"
ZSH_CONFIG_DIR="$HOME/.zsh"
ZSH_CONFIG_FILE="$HOME/.zshrc"

alias showzshrefcard="echo http://www.bash2zsh.com/zsh_refcard/refcard.pdf && echo https://github.com/robbyrussell/oh-my-zsh/tree/master/lib"

mkcfglink() {
  if [ ! -h $HOME/$2 ] ; then
    ln -s $CONFIGSHOME/$1 $HOME/$2
    if [ $? -gt 0 ] ; then
      echo "Failed linking $1 to $2"
    fi
  fi
}

reloadzshrc() {
    echo "reloading from Dropbox"
    rm -f $ZSH_CONFIG_FILE
    ln -s $SOURCE_ZSH_CONFIG_FILE $ZSH_CONFIG_FILE
    source $ZSH_CONFIG_FILE
}

editzshrc() {
    if [ "$1" != "" ] ; then
        echo "What do you want to edit ?"
        echo "0) Just open the directory in macvim"
        echo ""
        echo "1) Main config file"
        echo "2) Aliases"
        echo "3) Zsh helpers"
        echo "4) Darwin configs"
        echo "5) Linux configs"
        read action
    else
        action=$1
    fi

    case "$action" in
        0) mvim $SOURCE_ZSH_CONFIG_DIR ;;
        1) vim $SOURCE_ZSH_CONFIG_FILE ;;
        2) vim $SOURCE_ZSH_CONFIG_DIR/aliases.zsh ;;
        3) vim $SOURCE_ZSH_CONFIG_DIR/zsh_helpers.zsh ;;
        4) vim $SOURCE_ZSH_CONFIG_DIR/darwin_configs.zsh ;;
        5) vim $SOURCE_ZSH_CONFIG_DIR/linux_configs.zsh ;;
    esac

    reloadzshrc
}

editsshconfig() {
    vim $CONFIGSHOME/sshconfig
    cp $CONFIGSHOME/sshconfig $HOME/.ssh/config
    echo "ssh config reloaded"
}

git-st-subdirs() {
  for i in * ; do
    if [ -d $i ] ; then
      if [ -d $i/.git ] ; then
        echo "---->" $i
        cd $i
        git st
        cd ..
      fi
    fi
  done
}
