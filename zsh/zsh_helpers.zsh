SOURCE_ZSH_CONFIG_DIR="$CONFIGSHOME/zsh"
SOURCE_ZSH_CONFIG_FILE="$SOURCE_ZSH_CONFIG_DIR/zshrc"
ZSH_CONFIG_DIR="$HOME/.zsh"
ZSH_CONFIG_FILE="$HOME/.zshrc"

alias showzshrefcard="echo http://www.bash2zsh.com/zsh_refcard/refcard.pdf && echo https://github.com/robbyrussell/oh-my-zsh/tree/master/lib"

reloadzshrc() {
    if [ -f $SOURCE_ZSH_CONFIG_FILE ] ; then
        echo "reloading from Dropbox"
        cp $SOURCE_ZSH_CONFIG_FILE $ZSH_CONFIG_FILE
    else
        echo "fetching from github"
        if [ ! -d $ZSH_CONFIG_DIR ] ; then mkdir $ZSH_CONFIG_DIR ; fi
        if [ ! -d $ZSH_CONFIG_DIR/tmp ] ; then mkdir $ZSH_CONFIG_DIR/tmp ; fi
        cd $ZSH_CONFIG_DIR/tmp
        curl https://nodeload.github.com/trodrigues/configs/tarball/master -o configs.tar.gz

        if [ -f configs.tar.gz ] ; then
            tar xvzf configs.tar.gz
            rm -f configs.tar.gz

            cp -r */zsh/* ../
            cd .. && rm -rf tmp

            cp zshrc $ZSH_CONFIG_FILE
        fi
    fi
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
