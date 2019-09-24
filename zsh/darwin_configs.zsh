if [ "$uname" = "Darwin" ] ; then
    export PATH=""

    # homebrew ruby
    export PATH="$PATH:/usr/local/opt/ruby/bin"
    export RUBY_VERSION_PATH=`ruby --version|/usr/local/bin/awk '{ print $2 }'|/usr/bin/cut -c -3`
    export PATH="$PATH:/usr/local/lib/ruby/gems/$RUBY_VERSION_PATH.0/bin"
    export LDFLAGS="-L/usr/local/opt/ruby/lib"
    export CPPFLAGS="-I/usr/local/opt/ruby/include"
    export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

    # rbenv ruby
    #export PATH="$PATH:$HOME/.rbenv/bin"
    #eval "$(rbenv init -)"

    # homebrew python
    export PATH="$PATH:/usr/local/opt/python/libexec/bin"

    # go
    export PATH="$PATH:/usr/local/gocode/bin"
    export GOPATH="/usr/local/gocode"

    # add local node modules to path
    export PATH="$PATH:./node_modules/.bin"

    export NVM_DIR="/Users/trodrigues/.nvm"

    # General path definitions
    export PATH="$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
    export PATH="$PATH:/usr/X11/bin:/opt/local/bin:/usr/local/git/bin"

    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    export VAGRANT_DEFAULT_PROVIDER="virtualbox"

    # increase the number of processes per uid
    ulimit -u 1024
    ulimit -n 6000

    if [ -f /usr/local/etc/cacert.pem ] ; then
      export SSL_CERT_FILE=/usr/local/etc/cacert.pem
    fi

    colorarg="-G"

    # Start ssh agent
    #eval "$(ssh-agent -s)"

    #function code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args "$@"; }
fi
