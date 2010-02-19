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

get_git_branch() {
    test -n "$__CURRENT_GIT_VARS_INVALID" && zsh_git_compute_vars
    echo $__CURRENT_GIT_BRANCH
}

get_kube_ctx() {
    echo `kubectl config current-context 2>/dev/null`
}

# prompt config
function prompt {
    if [ "$(get_git_branch)" = "" ] ; then
        GIT_START=""; GIT_END="";
    else
        GIT_START="["; GIT_END="]";
    fi
    if [ "$(get_kube_ctx)" = "" ] ; then
        KUBE_CTX_START=""; KUBE_CTX_END="";
    else
        KUBE_CTX_START="{"; KUBE_CTX_END="}";
    fi
    PS1=""
    PS1=$PS1"%F{green}%4~"
    PS1=$PS1"%f%F{yellow}$GIT_START"
    PS1=$PS1"$(get_git_branch)$GIT_END%f "
    if [ "$SSH_TTY" != "" ] ; then
        PS1=$PS1"%F{magenta}%m%f"
    fi
    PS1=$PS1$'\n'
    #PS1=$PS1"%f%F{yellow}$KUBE_CTX_START"
    #PS1=$PS1"$(get_kube_ctx)$KUBE_CTX_END%f"
    PS1=$PS1"%F{green}>%f "
}
prompt

# necessary for tmux gitbar
#precmd() { eval "$PROMPT_COMMAND" }
