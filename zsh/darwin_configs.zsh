if [ "$uname" = "Darwin" ] ; then
    export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
    export PATH="$PATH:$HOME/.rbenv/bin:/usr/local/gocode/bin"
    export PATH="$PATH:/usr/X11/bin:/opt/local/bin:/usr/local/git/bin"
    export PATH="$PATH:/Users/trodrigues/android-sdk-macosx/tools:/Users/trodrigues/android-sdk-macosx/platform-tools"
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

    export DOCKER_HOST=tcp://192.168.59.103:2376
    export DOCKER_CERT_PATH=$HOME/.boot2docker/certs/boot2docker-vm
    export DOCKER_TLS_VERIFY=1
fi

alias contentful-start="cd $HOME/contentful/lab && vagrant up && ssh -t lab -- tmuxinator start user_interface"
alias contentful-stop="cd $HOME/contentful/lab && vagrant halt -f"
alias contentful-restart="cd $HOME/contentful/lab && vagrant halt -f && vagrant up && ssh -t lab -- tmuxinator start user_interface"
alias contentful-ssh="cd $HOME/contentful/lab && ssh -t lab -- tmuxinator start user_interface"

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

function backup_iphoto_lib(){
  rsync -avz ~/Pictures/iPhoto\ Library/ /Volumes/elements/iPhoto\ Library
  rsync -avz ~/Pictures/iPhoto\ Library/ /Volumes/external/iPhoto\ Library
}

function restart {
  stop $1 && start $1
}

sshuttle(){
  cwd=`pwd`
  cd $HOME/code/github/sshuttle
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

cdfzz() {
  local file=$(fzz find . -iname "*{{}}*" | head -n 1)
  local filedir=$(dirname ${file})
  cd ${filedir}
}
