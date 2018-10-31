if [ "$uname" = "Linux" ] ; then
    export NVM_DIR="/home/trodrigues/.nvm"
    export PATH="$PATH:./node_modules/.bin"
    export PATH="$PATH:/usr/local/git/bin:/opt/local/bin"
    colorarg="--color"
fi
