export CONTENTFUL_ACCESS_TOKEN="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
export CONTENTFUL_ORGANIZATION="contentful"
export CONTENTFUL_HOST="api.joistio.com:8888"
export LASTFM_API_KEY="03bcb2e6e4f46357bcd5099cbb341a96"
export CF_EMAIL="tiago@contentful.com"

cdtocontentfului(){
  if [[ "`pwd`" =~ \/contentful\/lab\/user_interface ]] ; then
    cd $HOME/contentful/lab/user_interface/$1
  fi
}

cdui(){
  cdtocontentfului
}

cdjs(){
  cdtocontentfului 'app/assets/javascripts'
}

cdcjs(){
  cdtocontentfului 'app/assets/commonjs_modules/user_interface'
}

cdcss(){
  cdtocontentfului 'app/assets/stylesheets'
}

cdunit(){
  cdtocontentfului 'spec/javascripts/contentful/unit'
}

cdspecjs(){
  cdtocontentfului 'spec/javascripts'
}


