uname=$(uname)

if [ "$SSH_TTY" != "" ] ; then
    hostname=$(hostname)
fi

# colors for ls, etc.
if [ "$uname" == "Darwin" ] ; then
    httpd_accesslog="/opt/local/etc/nginx/logs/access.log"
    httpd_errorlog="/opt/local/etc/nginx/logs/error.log"
    PATH="$PATH:/usr/local/git/bin:/opt/local/bin"
    colorarg="-G"
    ulimit -u 400
fi

if [ "$uname" == "Linux" ] ; then
    httpd_accesslog="/var/log/apache2/access.log"
    httpd_errorlog="/var/log/apache2/error.log"
    colorarg="--color"
fi

#git branch on prompt
function parse_git_branch {
    local branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ "$branch" != "" ] ; then
        echo "["$branch"] "
    fi
}

function proml {
    local        BLUE="\[\033[0;34m\]"
    local         RED="\[\033[0;31m\]"
    local   LIGHT_RED="\[\033[1;31m\]"
    local       GREEN="\[\033[0;32m\]"
    local LIGHT_GREEN="\[\033[1;32m\]"
    local       WHITE="\[\033[0;38m\]"
    local  LIGHT_GRAY="\[\033[0;37m\]"
    local      YELLOW="\[\033[0;33m\]"
    case $TERM in
        xterm*)
            TITLEBAR='\[\033]0;\u@\h:\w\007\]'
        ;;
        *)
            TITLEBAR=""
        ;;
    esac

    # my prompt
    PS1=""
    PS1=$PS1"$GREEN\W "
    PS1=$PS1"$YELLOW\$(parse_git_branch)"
    PS1=$PS1"$GREEN$hostname\$ "
    PS1=$PS1"$WHITE"
    PS2='> '
    PS4='+ '
}
proml

PATH="$PATH:/opt/cxoffice/bin:Software/android-sdk-linux_x86-1.6_r1/tools"

#my aliases
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
alias reloadbashrc="cp $HOME/Nextcloud/configs/bashrc $HOME/.bashrc && source $HOME/.bashrc"
alias reloadzshrc="cp $HOME/Nextcloud/configs/zshrc $HOME/.zshrc && source $HOME/.zshrc"

alias antena3="mplayer mms://rdp.oninet.pt/antena3"
alias starcraft="wine software/games/Starcraft/StarCraft.exe"
alias rtp1="mplayer mms://195.245.176.20/rtp"

alias mp3showdir="python $HOME/code/python_scripts/show_all_mp3_tags.py"
alias mp3renamedir="python $HOME/code/python_scripts/rename_mp3_dir.py"
alias add_package_key="bash $HOME/code/bashscripts/add_package_key.sh"

alias present="python $HOME/software/impressive/impressive.py -c memory -T 200 -t Crossfade,WipeLeft "
