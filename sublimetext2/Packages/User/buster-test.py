import sublime, sublime_plugin
import string, os, subprocess

def go_up(file_name):
  file_path = file_name.split('/')
  file_path.pop(len(file_path)-1)
  return string.join(file_path, '/')

def look_for_node_modules(file_name):
  file_dir = go_up(file_name)
  if "node_modules" in os.listdir(file_dir):
    os.chdir(file_dir)
    subprocess.call(['make', 'test'], shell=True)
    print "done"
  else:
    look_for_node_modules(file_dir)


class BusterTestCommand(sublime_plugin.TextCommand):
  def run(self, edit):
    look_for_node_modules(self.view.file_name())
