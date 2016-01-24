if [ "$uname" = "Darwin" ] ; then
    export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
    export PATH="$PATH:$HOME/.rbenv/bin:/usr/local/gocode/bin"
    export PATH="$PATH:/usr/X11/bin:/opt/local/bin:/usr/local/git/bin"
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
fi

function start {
  find ~/Library/LaunchAgents/ -name "*$1*"
  find ~/Library/LaunchAgents/ -name "*$1*" -exec launchctl load {} \;
}

function stop {
  find ~/Library/LaunchAgents/ -name "*$1*"
  find ~/Library/LaunchAgents/ -name "*$1*" -exec launchctl unload {} \;
}

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

mvim(){
  if [ -f .vim_session ] ; then
    local session=`cat .vim_session`
    if [ "$session" != "" ] ; then
      /usr/local/bin/mvim -S $HOME/.vim/sessions/$session.vim
    fi
  else
    /usr/local/bin/mvim $*
  fi
}
