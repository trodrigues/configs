# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' max-errors 0
zstyle ':completion:*' prompt 'Found %e errors'
zstyle ':completion:*' substitute 1
sshconfig="$HOME/.ssh/config"
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $sshconfig
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=6000
SAVEHIST=6000
setopt appendhistory extendedglob nomatch notify promptsubst 
setopt completealiases vi zle
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install


# open vi with sudo when needed
function vi {
   LIMIT=$#
   for ((i = 1; i <= $LIMIT; i++ )) do
       eval file="\$$i"
       if [[ -e $file && ! -O $file ]]
       then
           otherfile=1
       else

       fi
   done
   if [[ $otherfile = 1 ]]
   then
       sudo vi "$@"
   else
       command vi "$@"
   fi
}
vim=vi

export EDITOR=/usr/bin/vi

uname=$(uname)

# colors for ls, etc.
if [ "$uname" = "Darwin" ] ; then
    export PATH="$PATH:$HOME/Code/android-sdk-mac_86/tools"
    export PATH="$PATH:$HOME/Code/BlackBerry/SDK/net.rim.eide.componentpack4.7.0_4.7.0.46/components/bin"
    export PATH="$PATH:$HOME/Code/github/narwhal/bin"
    export PATH="$PATH:/opt/PalmSDK/Current/bin"
    export PATH="$PATH:/usr/local/git/bin:/usr/local/bin:/opt/local/bin"
    httpd_accesslog="/opt/local/etc/nginx/logs/access.log"
    httpd_errorlog="/opt/local/etc/nginx/logs/error.log"
    colorarg="-G"
    # increase the number of processes per uid
    ulimit -u 400
fi

if [ "$uname" = "Linux" ] ; then
    export PATH="$PATH:/opt/cxoffice/bin:Software/android-sdk-linux_x86-1.6_r1/tools"
    export PATH="$PATH:/usr/local/git/bin:/opt/local/bin"
    httpd_accesslog="/var/log/apache2/access.log"
    httpd_errorlog="/var/log/apache2/error.log"
    colorarg="--color"
fi

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# showing git branch
export __CURRENT_GIT_BRANCH=
export __CURRENT_GIT_VARS_INVALID=1


function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

zsh_git_invalidate_vars() {
    export __CURRENT_GIT_VARS_INVALID=1
    prompt
}
zsh_git_compute_vars() {
    export __CURRENT_GIT_BRANCH="$(parse_git_branch)"
    export __CURRENT_GIT_VARS_INVALID=
}

chpwd_functions+='zsh_git_chpwd_update_vars'
zsh_git_chpwd_update_vars() {
    zsh_git_invalidate_vars
}

preexec_functions+='zsh_git_preexec_update_vars'
zsh_git_preexec_update_vars() {
    case "$(history $HISTCMD)" in 
        *git*)
            zsh_git_invalidate_vars
        ;;
    esac
}

precmd_functions+=prompt

get_git_prompt_info() {
    test -n "$__CURRENT_GIT_VARS_INVALID" && zsh_git_compute_vars
    echo $__CURRENT_GIT_BRANCH
}

# prompt config
function prompt {
    if [ "$(get_git_prompt_info)" = "" ] ; then
        GIT_START=""; GIT_END="";
    else
        GIT_START="["; GIT_END="]";
    fi
    PS1=""
    PS1=$PS1"%F{green}%4~"
    PS1=$PS1"%f%F{yellow}$GIT_START"
    PS1=$PS1"$(get_git_prompt_info)$GIT_END%f "
    if [ "$SSH_TTY" != "" ] ; then
        PS1=$PS1"%F{magenta}%m%f"
    fi
    PS1=$PS1"%F{green}%#%f "
}
prompt

export PYTHONPATH="/Users/trodrigues/Code/bliki/evernote-api-1.14/lib/python"

reloadzshrc() {
    if [ -f $HOME/Dropbox/configs/zshrc ] ; then
        cp $HOME/Dropbox/configs/zshrc $HOME/.zshrc
    else
        echo "fetching from github"
        wget http://github.com/trodrigues/configs/raw/master/zshrc
        cp zshrc $HOME/.zshrc
        rm -f zshrc
    fi
    source $HOME/.zshrc
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

compress_js(){
    if [ "$2" = "" ] ; then
        minified=`echo "$1"|sed 's/\(.*\).js/\1.min.js/'`
    else
        minified=$2
    fi
    /opt/local/bin/jsmin <$1> $minified
}

goodfellas_update(){
    scp "sprawl:/home/trodrigues/trodrigues.net/htdocs/bons_rapazes/*.ogg" $HOME/Dropbox/bons_rapazes/
}

# my aliases
alias ls="ls $colorarg"
alias ll="ls $colorarg -l"
alias la="ls $colorarg -a"
alias lla="ls $colorarg -la"

alias rm_pyc="find . -name \"*.pyc\" -exec rm '{}' \;"
alias rm_swp="find . -name \"*.swp\" -exec rm '{}' \;"
alias rm_vim_mchars="perl -pi -e '$m=chr(13);s/$m//g'"
alias killpid="$HOME/code/bashscripts/kill_by_pid.sh"

alias tailaccess="tail -f $httpd_accesslog"
alias tailerror="tail -f $httpd_errorlog"
alias reloadbashrc="cp $HOME/Dropbox/configs/bashrc $HOME/.bashrc && source $HOME/.bashrc"

alias antena3="mplayer mms://rdp.oninet.pt/antena3"
alias starcraft="wine software/games/Starcraft/StarCraft.exe"
alias rtp1="mplayer mms://195.245.176.20/rtp"

alias mp3showdir="python $HOME/code/python_scripts/show_all_mp3_tags.py"
alias mp3renamedir="python $HOME/code/python_scripts/rename_mp3_dir.py"
alias add_package_key="bash $HOME/code/bashscripts/add_package_key.sh"

alias present="python $HOME/software/impressive/impressive.py -c memory -T 200 -t Crossfade,WipeLeft "
alias mytvshows="$HOME/Code/bashscripts/mytvshows.sh"

alias rhino="java -jar /Users/trodrigues/Code/javascript/rhino1_7R2/js.jar"
alias jslint="java -jar /Users/trodrigues/Code/javascript/rhino1_7R2/js.jar /Users/trodrigues/Code/javascript/jslint.js"