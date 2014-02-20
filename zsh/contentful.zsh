export CONTENTFUL_ACCESS_TOKEN="aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
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

cdcss(){
  cdtocontentfului 'app/assets/stylesheets'
}

cdunit(){
  cdtocontentfului 'spec/javascripts/contentful/unit'
}

cdspecjs(){
  cdtocontentfului 'spec/javascripts'
}


