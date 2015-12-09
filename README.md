# locate-sublime-projects-cli
This small autocompletion plugin for ZSH allows to search for Sublime Text projects and opens them.

This is only intended to work on OSX right now because it uses mdfind to quiclky search for files without creating a cache. If someone wants to make a pull request using the ZSH functions and alternatives for other platforms, you'd be welcome.

## Install
You can either add this as a zsh plugin in a OhMyZsh folder that's already included in your fpath variable or simply open

```vi ~/.zshrc```

And source it ad the end of the file

```source ~/path/to/locate-sublime-projects/sublime-completion.zsh```

## Usage
The interest of creating such functions is to be able to move quickly in the command line from one Sublime Project to another without needing to CD.

### sp $name
Searches for a sublime project named $name and opens it

### spo $name
Searches for a Sublime project named $name and opens the parent directory of the .sublime-project file.

### spcd $name
Searches for a Sublime project named $name and cd's to the .sublime-project's directory.

### Autocompletion
mdfind (Spotlight index) is also used to provide ZSH autocompletion. Use sp + tab to see a list of all the .sublime-project files found on your computer. Finish typing the suggested basename to use the function.