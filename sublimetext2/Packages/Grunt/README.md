sublime-grunt
=============

A Grunt task runner for Sublime Text

## Usage

Open the command palette using Ctrl+Shift+P (or Cmd+Shift+P on Mac, respectively)
and choose the "Grunt" command.

The plugin expects to find a Grunt file (`Gruntfile.js`) in an open folder.
It displays a list of available Grunt tasks out of this Grunt file.
If it finds more than one, it first provides a list for selection.

As of version 0.2, there is also a command to kill running tasks, for example
`watch` tasks.

## Settings

The file `SublimeGrunt.sublime-settings` is used for configuration.
You may have to add the path to your Node.js installation to the `path`
variable.

## Releases

* 0.1 Initial release
* 0.2 Rewrite; supports Grunt >= 0.4, tasks can be killed (for example the `watch` task)

## Thanks

Thanks for some contributions go to

* [antonellopasella](https://github.com/antonellopasella)
* [structAnkit](https://github.com/structAnkit)
* [lavrton](https://github.com/lavrton)