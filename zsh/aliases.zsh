alias pu="pushd"
alias po="popd"

alias timestamp="date \"+%Y%m%d%H%M%S\""

alias setgitignore="cp $HOME/Nextcloud/configs/gitignore .gitignore"

alias grep-node="ps aux|grep -v 'Code Helper'|grep -v 'Visual Studio'|grep -v Discord|grep node"

alias echo-path="echo $PATH|tr ':' '\n'"

alias mux="tmuxinator"

alias pn="pnpm"
alias pnx="pnpx"

alias j="jump"

function npm-open(){
  open https://npmjs.com/package/$1
}

function lag() {
  ag --color "$@" | less -r
}

which explorer.exe > /dev/null
if [ $? -eq 0 ] ; then
  alias open=explorer.exe
  alias pbcopy=clip.exe
fi

which xclip > /dev/null
if [ $? -eq 0 ] ; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

function getipv4 {
  ipv4=`curl -s ipv4.icanhazip.com`
  echo $ipv4| pbcopy
  echo "$ipv4 in clipboard"
}

function getipv6 {
  ipv6=`curl -s ipv6.icanhazip.com`
  echo $ipv6| pbcopy
  echo "$ipv6 in clipboard"
}
