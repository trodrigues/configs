if [ "$uname" = "Darwin" ] ; then
    export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
    export PATH="$PATH:/usr/X11/bin:/opt/local/bin:/usr/local/git/bin"
    export MANPATH="$MANPATH:/Users/trodrigues/Code/javascript/node/share/man"
    colorarg="-G"

    # increase the number of processes per uid
    ulimit -u 400
fi

function start {
  find ~/Library/LaunchAgents/ -name "*$1*"
  find ~/Library/LaunchAgents/ -name "*$1*" -exec launchctl load {} \;
}

function stop {
  find ~/Library/LaunchAgents/ -name "*$1*"
  find ~/Library/LaunchAgents/ -name "*$1*" -exec launchctl unload {} \;
}

alias start_nginx="/usr/local/bin/nginx_ctl"
alias stop_nginx="/usr/local/bin/nginx_ctl -s stop"
alias quit_nginx="/usr/local/bin/nginx_ctl -s quit"
alias reopen_nginx="/usr/local/bin/nginx_ctl -s reopen"
alias reload_nginx="/usr/local/bin/nginx_ctl -s reload"

function restart {
  stop $1 && start $1
}

sshuttle(){
  cwd=`pwd`
  cd $HOME/Dropbox/code/github/sshuttle
  ./sshuttle -r trodrigues@178.79.152.100:22522 0/0 -vv
  cd $cwd
}

function lag() {
  ag --color "$@" | less -r
}

# for sublimerge
function subldiff(){
  git show $1:$2|subl
}
