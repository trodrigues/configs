alias ls="ls $colorarg"
alias ll="ls $colorarg -l"
alias la="ls $colorarg -a"
alias lla="ls $colorarg -la"

alias pu="pushd"
alias po="popd"
alias mdkir="mkdir -p"

alias timestamp="date \"+%Y%m%d%H%M%S\""

alias rm_vim_mchars="perl -pi -e '$m=chr(13);s/$m//g'"

alias reloadbashrc="cp $HOME/Dropbox/configs/bashrc $HOME/.bashrc && source $HOME/.bashrc"

alias setgitignore="cp $HOME/Dropbox/configs/gitignore .gitignore"

alias vmwarefusion_setports="sudo vim /Library/Application\ Support/VMware\ Fusion/vmnet8/nat.conf"
alias vmwarefusion_reloadports="sudo /Library/Application\ Support/VMware\ Fusion/boot.sh --restart"

alias sync-music="rsync -avz /Users/trodrigues/Music/iTunes/iTunes\ Media/Music/* /Volumes/external/music/"

alias git-firewall-bypass="git config --global url.\"https://\".insteadOf git://"

docker-rm-ps(){
  docker rm `docker ps -a -q`
}
docker-rmi-untagged(){
  docker rmi `docker images | awk '$$2 ~ /none/ {print $$3}'`
}

docker-start(){
  dinghy up
  eval "$(docker-machine env dinghy)"
}
docker-stop-all(){
  docker stop `docker ps -q`
}
docker-env-eval(){
  eval "$(docker-machine env $1)"
}

if [ `docker-machine ls --filter name=dinghy --filter state=Running -q|wc -l` -gt 0 ] ; then
  eval "$(docker-machine env dinghy)"
fi

