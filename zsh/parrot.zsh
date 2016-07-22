function parrot () {
  if [ $# -eq 0 ] ; then
    ls ~/Pictures/parrots/
  else
    imgcat ~/Pictures/parrots/$1.gif
  fi
}
