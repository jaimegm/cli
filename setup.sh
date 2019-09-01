# Install core xcode
xcode-select --install

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils

# Install Bash 4
brew install bash

PACKAGES=(
    #postgresql
    python3
    python
    tree
    wget
    vim
    git
    zsh
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


CASKS=(
    google-chrome
    google-drive-file-stream
    sublime-text
    spectacle
    iterm2
	#slack
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Installing Node ..."
brew install node

echo "Installing Nativefier ..."
npm install nativefier -g

echo "Downloading card-id hack ..."
curl --remote-name https://raw.githubusercontent.com/annaminton/trello-osx-install/master/display-card-ids.css

echo "Creating Trello app ..."
nativefier --name "Trello" "http://trello.com" --inject display-card-ids.css

echo "Moving to Applications ..."
rsync -a ~/Trello-darwin-x64/Trello.app/ /Applications/Trello.app/

echo "Creating Dock icon"
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Trello.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
killall Dock

echo "Installing fonts..."
brew tap caskroom/fonts

echo "Downloading Terminal Hack Font..."
wget https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip

SAVEIFS=$IFS
IFS="$(printf '\n\t')"

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *.zpaq)      zpaq x ./"$n"      ;;
            *.arc)         arc e ./"$n"       ;;
            *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                              extract $n.iso && \rm -f $n ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

extract Hack-v3.003-ttf.zip 

cp ttf/* /Library/Fonts/ && echo "Installed Fonts..."

rm -r ttf/
rm -r Hack-v3.003-ttf.zip
rm -r display-card-ids.css
rm -r Trello-darwin-x64

echo "Cleaning up...."

echo "Installing Python packages..."
PYTHON_PACKAGES=(
        psycopg2-binary
        oauth2client
        google-api-python-client
        pandas
        python-dateutil
        google
        google-api-core
        pandas-gbq==0.10.0
        requests-oauthlib
        #atlassian-python-api==1.13.5
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

echo "Installing /.bash_profile"

echo "
export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH 
# Util Scripts
# HISTORY FILE SETTINGS	
export HISTIGNORE='ls:ps:history'  					# Ignore thes commands in History File
HISTTIMEFORMAT='%h %d %H:%M:%S'						# Add timestamp information to history file
PROMPT_COMMAND='history -a' 						# Save Command instantly, instead after successful session
HISTCONTROL=ignoreboth								# Dont duplicate lines or lines starting with space in the history.
 								# Append commands to History instead of overwrite
HISTFILESIZE=20000 									# History file size
HISTSIZE=10000 										# History command length
									# Store multi-line commands as single line
# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export EDITOR='subl -w'” "| sudo tee -a filename >  ~/.bash_profile

. ~/.bash_profile && echo "sourced .bash_profile"

echo "Installing /.bash_aliases"

echo "
# Alias Defintion File

# Directory Shortcuts
alias air='cd ~/code/airflow'
alias ah='cd ~/code/aroundhome'
alias dags='cd ~/code/dags'
alias code='cd ~/code/'
alias home='cd ~/'
alias docs='cd ~/Documents'
alias down='cd ~/Downloads'
alias play='cd ~/code/playground'
alias utils='cd ~/code/utils'

# Nav Shortcuts
alias .....='cd ../../../../'
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ../'

# Quick-Commands
alias vpn='cd ~/ && sudo openvpn client.ovpn'
alias update='pip install --upgrade .'
alias ezsh='sudo subl ~/.zshrc'
alias szsh='source ~/.zshrc'
alias ea='sudo subl ~/.bash_aliases'
alias sa='source ~/.bash_aliases'
alias spin='. venv/bin/activate'
alias dspin='deactivate'
alias history='history -E'
alias jup='jupyter notebook'

# Command Shortcuts & Enhancements
# sleep 10; alert
alias la='ls -A'                            # List all files
alias l='ls -CF'
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias c='clear'

# Git Shortcuts
alias commit='git commit -m'
alias clone='git clone'
alias gc='git checkout'
alias pull='git pull'
alias push='git push'
alias gs='git status'
alias stash='git stash'
alias unstash='git stash pop'
alias nbranch='git checkout -b'
alias pbranch='git push -u origin'
alias gcm='git checkout master'

# Airflow Shortcuts
alias aweb='airflow webserver'
alias sch='airflow scheduler'
 "| sudo tee -a filename >  ~/.bash_aliases


echo "Installing /.zshrc"

echo "
# Path to your oh-my-zsh installation.
# export ZSH="/home/jaime/.oh-my-zsh"         # ZSH Home
export UPDATE_ZSH_DAYS=30             # Update Cycle
export LANG=en_US.UTF-8               # System Lanaguage

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="'random'"
ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "awesomepanda" "solarized-powerline" )

# Terminal Behaviour
HYPHEN_INSENSITIVE="true"     # Make - & _ Interchangeable
ENABLE_CORRECTION="true"      # Enable Auto-Correction
COMPLETION_WAITING_DOTS="true"    # Completion Waiting Dots

##############################################################################
# History Configuration
##############################################################################
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=50000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=10000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed



# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Plugin Configuration
plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
    brew
    osx
    git
    )

#source ~/.oh-my-zsh/oh-my-zsh.sh
source ~/oh-my-zsh/custom/aliases.zsh
 "| sudo tee -a filename >  ~/.zshrc

source ~/.zshrc && echo "Sourced ~/.zshrc"

echo "Installing ~/.oh-my-zsh/custom/aliases.zsh"

echo "
# Alias Defintion File

# Directory Shortcuts
alias play='cd ~/code/playground'
alias stor='cd ~/Volumes/Storage'
alias infarm='cd ~/code/infarm'
alias ah='cd ~/code/aroundhome'
alias utils='cd ~/code/utils'
alias air='cd ~/code/airflow'
alias dags='cd ~/code/dags'
alias docs='cd ~/Documents'
alias down='cd ~/Downloads'
alias desk='cd ~/Desktop'
alias code='cd ~/code/'
alias home='cd ~/'

# Nav Shortcuts
alias ......='cd ../../../../../'
alias .....='cd ../../../../'
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ../'

# Quick-Commands
alias vpn='cd ~/ && sudo openvpn client.ovpn'
alias update='pip install --upgrade .'
alias ezsh='subl ~/.zshrc'
alias szsh='source ~/.zshrc'
alias ea='subl ~/.oh-my-zsh/custom/aliases.zsh'
alias sa='source ~/.oh-my-zsh/custom/aliases.zsh'
alias spin='. venv/bin/activate'
alias dspin='deactivate'
alias jup='jupyter notebook'

# Command Shortcuts & Enhancements
# sleep 10; alert
alias la='ls -A'                            # List all files
alias l='ls -CF'
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias c='clear'
# Git Shortcuts
alias commit='git commit -m'
alias clone='git clone'
alias gc='git checkout'
alias pull='git pull'
alias push='git push'
alias gs='git status'
alias stash='git stash'
alias unstash='git stash pop'
alias nbranch='git checkout -b'
alias pbranch='git push -u origin'

# Airflow Shortcuts
alias aweb='airflow webserver'
alias sch='airflow scheduler'
 "| sudo tee -a filename >  ~/.oh-my-zsh/custom/aliases.zsh


echo "Installing Zsh Themes"
cd ~/.oh-my-zsh/custom/themes
wget https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/miloshadzic.zsh-theme
wget https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/awesomepanda.zsh-theme
git clone https://github.com/KuoE0/oh-my-zsh-solarized-powerline-theme.git
ln -s $PWD/solarized-powerline.zsh-theme ~/.oh-my-zsh/themes

echo "Installing Zsh Plugins"
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions



echo "Configuring OSX..."

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
source ~/.bash_aliases 
echo "source /.bash_aliases"
source ~/.oh-my-zsh/custom/aliases.zsh
echo "sourced aliases.zsh"

cd ~/
mkdir code
mkdir code/infarm
mkdir code/airflow
mkdir code/dags
mkdir code/utils
mkdir code/playground

echo "Bootstrapping complete"
