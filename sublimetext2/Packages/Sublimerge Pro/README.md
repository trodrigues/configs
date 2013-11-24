Sublimerge
==========

Sublimerge is a Sublime Text 2/3 plugin which allows to diff and merge files DIRECTLY in the editor using graphical interface for that purpose.

If file is under GIT or SVN it is now possible to compare it with its other revisions. This is experimental feature and can be simply
turned off via package settings (vcs_support). Please report any problems with this feature. Requires svn or git to be installed.

![Sublimerge](http://cloud.github.com/downloads/borysf/Sublimerge/Screenshot2.png "Sublimerge")

Installation
------------

If you are using Will Bond's Package Control, you can easily install Sublimerge with `Package Control: Install Package`.
Otherwise you can simply clone this repo in Sublime Text 2' Packages directory.

Note for Sublime Text 3 users
-----------------------------
Sublimerge is now experimentally ported for ST 3. Installation instructions can be found in branch sublime-text-3: https://github.com/borysf/Sublimerge/tree/sublime-text-3 in README.md file.

Donation
--------

If you find this plugin useful, you can say "thanks" by Donation: http://borysforytarz.pl/sublimerge.html :)

Default key bindings (platform independent)
------------------------------------------

`[ctrl]+[alt]+[d]` - open files menu to select the file you wish diff the current file to 

`[ctrl]+[alt]+[,]` - merge the change from right to left  
`[ctrl]+[alt]+[.]` - merge the change from left to right  

`[ctrl]+[alt]+[/] + [ctrl]+[alt]+[,]` - merge all changes from right to left  
`[ctrl]+[alt]+[/] + [ctrl]+[alt]+[.]` - merge all changes from left to right  

`[ctrl]+[alt]+[=]` or `[ctrl]+[alt]+[pagedown]` - go to the next difference  
`[ctrl]+[alt]+[-]` or `[ctrl]+[alt]+[pageup]` - go to the previous difference  


Access from context menus
-------------------------

You can access Sublimerge from the following context menus:
- Side Bar: one selected file  
  ![Sublimerge](http://borysforytarz.pl/img/context-one-file.png "Sublimerge")

- Side Bar: two selected files  
  ![Sublimerge](http://borysforytarz.pl/img/context-two-files.png "Sublimerge")

- Editor: View  
  ![Sublimerge](http://borysforytarz.pl/img/context-text-area.png "Sublimerge")

- Editor: File's tab  
  ![Sublimerge](http://borysforytarz.pl/img/context-tab.png "Sublimerge")  

--
Because this is my first Sublime Text 2 plugin and the first Python code I have ever written, probably some things could be done
better - any feedback is welcome!

https://github.com/borysf/Sublimerge  
borys.forytarz@gmail.com  
http://borysforytarz.pl  
