if [ "$uname" = "Darwin" ] ; then
    export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
    export PATH="$PATH:/usr/X11/bin:/opt/local/bin:/usr/local/git/bin"
    export MANPATH="$MANPATH:/Users/trodrigues/Code/javascript/node/share/man"
    colorarg="-G"

    export CC="/Developer/usr/bin/gcc"
    export CXX="/Developer/usr/bin/g++"
    export LD="/Developer/usr/bin/gcc"

    # increase the number of processes per uid
    ulimit -u 400
fi

function start {
  find ~/Library/LaunchAgents/ -name "*$1*" -exec launchctl load {} \;
}

function stop {
  find ~/Library/LaunchAgents/ -name "*$1*" -exec launchctl unload {} \;
}

function restart {
  stop $1 && start $1
}

# manage webserver
start_nginx(){
    sudo launchctl load /Users/trodrigues/Library/LaunchDaemons/com.trodrigues.nginx.plist
}

stop_nginx(){
    sudo launchctl unload /Users/trodrigues/Library/LaunchDaemons/com.trodrigues.nginx.plist
}

start_phpfcgi(){
    sudo launchctl load /Users/trodrigues/Library/LaunchDaemons/com.trodrigues.php-fastcgi.plist
}

stop_phpfcgi(){
    sudo launchctl unload /Users/trodrigues/Library/LaunchDaemons/com.trodrigues.php-fastcgi.plist
}

start_mysql(){
    sudo /opt/local/lib/mysql5/bin/mysqld_safe &
}

reload_webserver(){
    stop_nginx
    stop_phpfcgi
    sleep 2
    start_nginx
    start_phpfcgi
    ps aux|grep nginx
    ps aux|grep php
}


