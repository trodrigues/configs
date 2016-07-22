if [ "$uname" = "Darwin" ] ; then
    export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
    export PATH="$PATH:$HOME/.rbenv/bin:/usr/local/gocode/bin"
    export PATH="$PATH:/usr/X11/bin:/opt/local/bin:/usr/local/git/bin"
    export PATH="$PATH:./node_modules/.bin"
    export MANPATH="$MANPATH:/Users/trodrigues/Code/javascript/node/share/man"
    colorarg="-G"

    export VAGRANT_DEFAULT_PROVIDER="virtualbox"
    export GOPATH="/usr/local/gocode"

    # increase the number of processes per uid
    ulimit -u 400
    ulimit -n 6000

    eval "$(rbenv init -)"

    if [ -f /usr/local/etc/cacert.pem ] ; then
      export SSL_CERT_FILE=/usr/local/etc/cacert.pem
    fi

    function code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args "$@"; }
fi
