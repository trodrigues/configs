if [ "$uname" = "Linux" ] ; then
    export PATH="$PATH:/usr/local/git/bin:/opt/local/bin"
    export PATH="$PATH:$HOME/.cargo/bin"
    eval "$(fnm env --use-on-cd)"
fi

if [ "$uname" = "Darwin" ] ; then
    if [ -x /usr/libexec/path_helper ] && [ -z $PATH ] ; then
      PATH=""
      eval `/usr/libexec/path_helper -s`
    fi

    HOMEBREW=/opt/homebrew
    export PATH="$HOMEBREW/bin:$PATH"

    # rustup env
    . "$HOME/.cargo/env"

    #. $(brew --prefix asdf)/libexec/asdf.sh

    eval "$(fnm env)"
    # add local node modules to path
    export PATH="$PATH:./node_modules/.bin"

    # x86 dotnet
    #export PATH="$PATH:/usr/local/share/dotnet/x64"

    # homebrew ruby
    export PATH="$HOMEBREW/opt/ruby/bin:$PATH"
    export RUBY_VERSION_PATH=`ruby --version|$HOMEBREW/bin/gawk '{ print $2 }'|/usr/bin/cut -c -3`
    export PATH="$HOMEBREW/lib/ruby/gems/$RUBY_VERSION_PATH.0/bin:$PATH"
    export LDFLAGS="-L$HOMEBREW/opt/ruby/lib"
    export CPPFLAGS="-I$HOMEBREW/opt/ruby/include"
    export PKG_CONFIG_PATH="$HOMEBREW/opt/ruby/lib/pkgconfig"

    # homebrew python
    export PATH="$HOMEBREW/opt/python/libexec/bin:$PATH"


    export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
    export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/php@8.1/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/php@8.1/include"

    # rbenv ruby
    #export PATH="$PATH:$HOME/.rbenv/bin"
    #eval "$(rbenv init -)"
    
    # go
    export PATH="$PATH:$HOMEBREW/gocode/bin"
    export GOPATH="$HOMEBREW/gocode"

    #export PATH="$HOME/.jenv/bin:$PATH"
    #eval "$(jenv init -)"

    export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"
    
    export PATH="$PATH:/usr/X11/bin:$HOMEBREW/git/bin"

    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

    # increase the number of processes per uid
    ulimit -u 1024
    ulimit -n 6000

    if [ -f $HOMEBREW/etc/cacert.pem ] ; then
      export SSL_CERT_FILE=$HOMEBREW/etc/cacert.pem
    fi

fi
