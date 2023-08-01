# Command Line Interface Config

This repository contains my custom command line interface setup. My preferred shell is [oh-my-zsh]
(https://ohmyz.sh/), which determines the name of some standard files like my shell config`.
zshrc`, aliases file `aliases.zsh`, and profiles file `.zprofile`. If your have not setup a 
custom shell like `oh-my-zsh` your most likely using bash. In that case my `zsh` files map to 
your bash files like so:

- `.zshrc` :: `.bashrc` or `.bash_profile`
  - These are your main shell configuration file. It defines the characteristic of ths shell 
    your using. typically the name of your files depend on the shell your using. `.zshrc` is for 
    `oh-my-zsh` while `.bashrc` is for bash. 
- `aliases.zsh` :: `.bash_aliases`
  - Alias files are used for storing command line shortcuts outside of your shell 
    configuration files (`.zshrc` or `.bashrc`). This is helpful because it prevents your shell 
    configuration file from becoming cluttered or extremely long. 
- `.zprofile` :: `.profile`
  - Profile files like this are used for storing environmental variables outside of your shell 
    configuration files. Thus keeping your shell configuration file concise and compact


# Table of Contents

- [Prerequisites](#prerequisites)
- [Gcloud Configuration](#gcloud-configuration)
- [Shortcuts](#shortcuts)
- [Zsh Plugins](#zsh-plugins)
- 

## Prerequisite

* [Brew](https://brew.sh/)
* [Pyenv](https://github.com/pyenv/pyenv#installation)
* [Direnv](https://direnv.net/)
* [Docker](https://www.docker.com/)
* [gcloud-sdk](https://cloud.google.com/sdk/docs/install)
* [Kubectl](https://kubernetes.io/docs/tasks/tools/)


## Gcloud Configuration

Gcloud configurations are for switching between different Google Projects. This is useful for working with production, staging, testing environments (Kosmos). Every developer should have a configuration for each project: `infarm-data, infarm-backend, staging-backend-235013,testing-software-284908`

```shell
# Create a gcloud configuration and authorize it
gcloud config configurations create work
gcloud config set project work-project_id
gcloud auth login
```

## Shortcuts

I will describe some of my most used CLI shortcuts. I use these shortcuts everyday either for 
development or making changes to my CLI configuration. Im currently using `pycharm` as my editor.
in the aliases below you can exchange `pycharm` for `subl` if your using [Sublime Editor]
(https://www.sublimetext.com/). I will show how to create these symlinks. They are incredibly 
useful to use from the command line because you can open a file directly in your editor of 
choice instead of using `vim` or `nano`. 

```shell
# open the alias file in my editor
alias ea='pycharm ~/config/cli/aliases.zsh'
# open cli custom functions file in editor
alias ef='pycharm ~/config/cli/functions.sh'
# open the profile file in my editor
alias ep='pycharm ~/.zprofile'
# open the shell config in my editor
alias ezsh='pycharm ~/.zshrc'
# Refresh shell config / update current shell
alias szsh='source ~/.zshrc'
```

### Sublime System-link
Run this in your terminal. Then run `subl .` from your terminal to test it was successful.
```code
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
```

### Pycharm System-link

Create a file `pycharm` with the following contents. 

```shell
#!/bin/sh

open -na "PyCharm.app" --args "$@"
```

- Move the file to your bin folder `mv pycharm /usr/local/bin/`
- Now make the file executable with `sudo chmod +x /usr/local/bin/pycharm`
- Now you can test if it works with `pycharm .`


## Install Cmds

```python
# Install On My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Zsh Plugins
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

```

Extract File Types
https://github.com/xvoland/Extract/blob/master/extract.sh

## Zsh Plugins

git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# Clone into /.oh-my-zsh/custom/themes/
git clone https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/awesomepanda.zsh-theme
git clone https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/sunrise.zsh-theme

# Make Shell Script Executable
chmod +x setup.sh

# Run Script
./setup.sh
