reloadzshrc() {
    if [ -f $CONFIGSHOME/zsh/zshrc ] ; then
        echo "reloading from Dropbox"
        cp $CONFIGSHOME/zsh/zshrc $HOME/.zshrc
    else
        echo "fetching from github"
        if [ ! -d $HOME/.zsh ] ; then mkdir $HOME/.zsh ; fi
        if [ ! -d $HOME/.zsh/tmp ] ; then mkdir $HOME/.zsh/tmp ; fi
        cd $HOME/.zsh/tmp
        curl https://nodeload.github.com/trodrigues/configs/tarball/master -o configs.tar.gz
        if [ -f configs.tar.gz ] ; then
            tar xvzf configs.tar.gz
            rm -f configs.tar.gz

            cp -r */zsh/* ../
            cd .. && rm -rf tmp

            cp zshrc $HOME/.zshrc
        fi
    fi
    source $HOME/.zshrc
}

