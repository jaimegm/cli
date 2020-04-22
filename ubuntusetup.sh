# Update packages
sudo apt-get update
sudo apt upgrade
# Install zsh
sudo apt install zsh
# Theme # Fonts
sudo apt-get install powerline fonts-powerline
# Clone Repo
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

sudo chsh -s /usr/bin/zsh root				# Make ZSH Default Shell

sudo apt install wget git  					# Install Git & wget Framework

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
