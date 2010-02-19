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

alias ibrew="arch -x86_64 /usr/local/homebrew/bin/brew"

alias roshell="arch -x86_64 zsh"
alias rorun="arch -x86_64"

alias timestamp="date \"+%Y%m%d%H%M%S\""

alias rm_vim_mchars="perl -pi -e '$m=chr(13);s/$m//g'"

alias reloadbashrc="cp $HOME/Dropbox/configs/bashrc $HOME/.bashrc && source $HOME/.bashrc"

alias setgitignore="cp $HOME/Dropbox/configs/gitignore .gitignore"

alias git-firewall-bypass="git config --global url.\"https://\".insteadOf git://"

alias grep-node="ps aux|grep -v 'Code Helper'|grep -v 'Visual Studio'|grep -v Discord|grep node"

alias echo-path="echo $PATH|tr ':' '\n'"

function show-notification(){
  osascript $HOME/Dropbox/configs/applescripts/notification.as
}

alias pn="pnpm"
alias pnx="pnpx"

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

function docker_node_container() {
	docker run --rm -v `pwd`:/app -w /app -it node:14-buster bash
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

function clear-scrollback-buffer {
  # Behavior of clear:
  # 1. clear scrollback if E3 cap is supported (terminal, platform specific)
  # 2. then clear visible screen
  # For some terminal 'e[3J' need to be sent explicitly to clear scrollback
  clear && printf '\e[3J'
  # .reset-prompt: bypass the zsh-syntax-highlighting wrapper
  # https://github.com/sorin-ionescu/prezto/issues/1026
  # https://github.com/zsh-users/zsh-autosuggestions/issues/107#issuecomment-183824034
  # -R: redisplay the prompt to avoid old prompts being eaten up
  # https://github.com/Powerlevel9k/powerlevel9k/pull/1176#discussion_r299303453
  zle && zle .reset-prompt && zle -R
}

zle -N clear-scrollback-buffer

function node-legacy {
  export NODE_OPTIONS=--openssl-legacy-provider
}
