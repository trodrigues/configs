git-bd() {
  local r="refs"
  [[ $1 ]] && r="$r/remotes/$1" || r="$r/heads"
  while read l; do
    echo ${l}
    echo "  " $(git log --date=short -1 --format="%ad %h  %s" ${l})
  done <<< $(git for-each-ref --format='%(refname:short)' --sort=-committerdate ${r})
}

git-st-subdirs() {
  for i in * ; do
    if [ -d $i ] ; then
      if [ -d $i/.git ] ; then
        echo "---->" $i
        cd $i
        git st
        cd ..
      fi
    fi
  done
}
