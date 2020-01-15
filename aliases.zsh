### Alias Defintion File ###
####--------------------####

# Directory Shortcuts
alias air='cd ~/code/grow_with_the_flow'
alias dags='cd ~/code/infarm-dags'
alias play='cd ~/code/playground'
alias ref='cd ~/code/reference'
alias docs='cd ~/Documents'
alias down='cd ~/Downloads'
alias desk='cd ~/Desktop'
alias sql='cd ~/code/sql'
alias creds='cd ~/creds'
alias code='cd ~/code/'
alias home='cd ~/'

# Nav Shortcuts
alias ......='cd ../../../../../'
alias .....='cd ../../../../'
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ../'

# Additional Nav Shortcuts!
alias mycode='cd /Volumes/Kr8tv/Users/Jaime/code'
alias me='cd /Volumes/Kr8tv/Users/Jaime/Desktop'

# Quick-Commands
alias sa='source ~/.oh-my-zsh/custom/aliases.zsh'
alias ea='subl ~/.oh-my-zsh/custom/aliases.zsh'
alias update='pip install --upgrade .'
alias spin='. venv/bin/activate'
alias jup='jupyter notebook'
alias szsh='source ~/.zshrc'
alias ezsh='subl ~/.zshrc'
alias dspin='deactivate'
alias pgen='openssl rand -base64 20'
alias mkvenv='python3 -m venv venv'

# Command Shortcuts & Enhancements
alias la='ls -A'                                 # List all files
alias l='ls -CF'
alias cp='sudo cp -iv'                           # Preferred 'cp' implementation
alias mv='sudo mv -iv'                           # Preferred 'mv' implementation
alias mkdir='sudo mkdir -pv'                     # Preferred 'mkdir' implementation
alias rmv='sudo rm -r'
alias c='clear'
alias startpg="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias stoppg="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"

# Git Shortcuts
alias commit='git commit -m'
alias clone='git clone'
alias gc='git checkout'
alias add='git add'
alias pull='git pull'
alias push='git push'
alias gs='git status'
alias stash='git stash'
alias unstash='git stash pop'
alias nbranch='git checkout -b'
alias pbranch='git push --set-upstream origin'
alias submodules='git config --file .gitmodules --get-regexp path | awk "{ print $2 }"'

# Airflow Shortcuts
alias growmachine='ssh -p 22 jaime@34.89.145.127'
alias aweb='airflow webserver'
alias sch='airflow scheduler'
