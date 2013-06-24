alias ls="ls $colorarg"
alias ll="ls $colorarg -l"
alias la="ls $colorarg -a"
alias lla="ls $colorarg -la"

alias pu="pushd"
alias po="popd"
alias mdkir="mkdir -p"

alias timestamp="date \"+%Y%m%d%H%M%S\""

alias rm_pyc="find . -name \"*.pyc\" -exec rm '{}' \;"
alias rm_swp="find . -name \"*.swp\" -exec rm '{}' \;"
alias rm_vim_mchars="perl -pi -e '$m=chr(13);s/$m//g'"
alias killpid="$HOME/code/bashscripts/kill_by_pid.sh"

alias tailaccess="tail -f $httpd_accesslog"
alias tailerror="tail -f $httpd_errorlog"
alias reloadbashrc="cp $HOME/Dropbox/configs/bashrc $HOME/.bashrc && source $HOME/.bashrc"

alias rhino="java -jar $HOME/Code/javascript/rhino1_7R2/js.jar"
alias jslint="java -jar $HOME/Code/javascript/rhino1_7R2/js.jar $HOME/Code/javascript/jslint.js"
alias yuicompressor="java -jar $HOME/Code/javascript/yuicompressor-2.4.2/build/yuicompressor-2.4.2.jar"
alias closurecompiler="java -jar $HOME/Code/javascript/compiler-latest/compiler.jar"

alias setgitignore="cp $HOME/Dropbox/configs/gitignore .gitignore"

alias vmwarefusion_setports="sudo vim /Library/Application\ Support/VMware\ Fusion/vmnet8/nat.conf"
alias vmwarefusion_reloadports="sudo /Library/Application\ Support/VMware\ Fusion/boot.sh --restart"

alias jstd="$CODEHOME/scripts/shell/js_test_driver.sh"
alias nave="$CODEHOME/github/nave/nave.sh"
alias reinstall-janus="$CODEHOME/scripts/shell/reinstall_janus.sh"

alias sync-sublime-session="$HOME/Dropbox/configs/sublimetext2/sync_sublime_session.sh"
alias set-sublime-session="$HOME/Dropbox/configs/sublimetext2/set_sublime_session.sh"

alias sync-music="rsync -avz /Users/trodrigues/Music/iTunes/iTunes\ Media/Music/* /Volumes/external/music/"

alias git-firewall-bypass="git config --global url.\"https://\".insteadOf git://"
