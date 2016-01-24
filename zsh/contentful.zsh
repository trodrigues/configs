export CONTENTFUL_ACCESS_TOKEN="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
export CONTENTFUL_ORGANIZATION="contentful"
export CONTENTFUL_HOST="api.joistio.com:8888"
export LASTFM_API_KEY="03bcb2e6e4f46357bcd5099cbb341a96"
export CF_EMAIL="tiago@contentful.com"

alias contentful-start="cd $HOME/contentful/lab && vagrant up && sleep 60 && ssh -t lab -- tmuxinator start user_interface"
alias contentful-stop="cd $HOME/contentful/lab && vagrant halt"
alias contentful-stop-f="cd $HOME/contentful/lab && vagrant halt -f"
alias contentful-restart="cd $HOME/contentful/lab && vagrant halt && vagrant up && sleep 60 && ssh -t lab -- tmuxinator start user_interface"
alias contentful-restart-f="cd $HOME/contentful/lab && vagrant halt -f && vagrant up && sleep 60 && ssh -t lab -- tmuxinator start user_interface"
alias contentful-ssh="cd $HOME/contentful/lab && ssh -t lab -- tmuxinator start user_interface"

cdtocontentfului(){
  if [[ "`pwd`" =~ \/contentful\/lab\/user_interface ]] ; then
    cd $HOME/contentful/lab/user_interface/$1
  fi
}

cdui(){
  cdtocontentfului
}


