
# Prereqs

* [Kubectl](https://kubernetes.io/docs/tasks/tools/)
* [Direnv](https://direnv.net/)
* [Docker](https://www.docker.com/)
* [Pyenv](https://github.com/pyenv/pyenv#installation)
* [Brew](https://brew.sh/)


## Directory Hierarchy

```sh
config/
|-- cli
|   |-- functions.sh 
|   |-- aliases.zsh
|   |-- .zshrc
|-- secrets
|-- sublime
|-- zsh_themes

```

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

# Install Plugins

git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# Clone into /.oh-my-zsh/custom/themes/
git clone https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/awesomepanda.zsh-theme
git clone https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/sunrise.zsh-theme

# Make Shell Script Executable
chmod +x setup.sh

# Run Script
./setup.sh
