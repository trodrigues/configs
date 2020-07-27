which exa > /dev/null
if [ $? -eq 0 ] ; then
  alias ls="exa"
  alias ll="COLUMNS=60 ls -l"
  alias ls1="ls -1"
  alias lt1="ls -T --level=1"
  alias la="ls -a"
  alias lla="COLUMNS=60 ls -la"
fi

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

function show-notification(){
  osascript $HOME/Dropbox/configs/applescripts/notification.as
}

function npm-open(){
  open https://npmjs.com/package/$1
}

function lag() {
  ag --color "$@" | less -r
}

alias mux="tmuxinator"
function mux-stop() {
  tmux kill-session -t $1
}

function testcafe-chrome-canary() {
  setopt -x
  testcafe 'path:`/Users/trodrigues/Applications/Google Chrome Canary.app`' $@
}

function testcafe-chrome() {
  setopt -x
  testcafe 'path:`/Users/trodrigues/Applications/Google Chrome.app`' $@
}

function testcafe-firefox() {
  setopt -x
  testcafe 'path:`/Users/trodrigues/Applications/Firefox.app`' $@
}

function roonya() {
	cp /Applications/kitty.app/Contents/Resources/kitty.icns /Applications/kitty.app/Contents/Resources/kitty.icns.bak
	cp ~/Dropbox/roonya.icns /Applications/kitty.app/Contents/Resources/kitty.icns
}

function take_home_test_container() {
	if [ "$1" = "" ] ; then
		echo "Please specify the port of the development server"
		exit 1
	fi
	docker run --rm -p 4000:$1 -v `pwd`:/app -w /app -it node:10-buster bash
}

function docker_node_container() {
	docker run --rm -v `pwd`:/app -w /app -it node:12-buster bash
}

function git-bd() {
  local r="refs"
  [[ $1 ]] && r="$r/remotes/$1" || r="$r/heads"
  while read l; do
    echo ${l}
    echo "  " $(git log --date=short -1 --format="%ad %h  %s" ${l})
  done <<< $(git for-each-ref --format='%(refname:short)' --sort=-committerdate ${r})
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

