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

