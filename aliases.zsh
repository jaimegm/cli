### Alias Defintion File ###
####--------------------####

# Directory Shortcuts
alias cloud='cd ~/code/cloud_function_dev'
alias air='cd ~/code/grow_with_the_flow'
alias dags='cd ~/code/infarm_dags'
alias play='cd ~/code/playground'
alias proj='cd ~/code/projects'
alias ref='cd ~/code/reference'
alias kosmos='cd ~/code/kosmos'
alias docs='cd ~/Documents'
alias down='cd ~/Downloads'
alias desk='cd ~/Desktop'
alias sql='cd ~/code/sql'
alias creds='cd ~/creds'
alias code='cd ~/code/'
alias home='cd ~/'

# Chrome
alias chrome='open /Applications/Google\ Chrome.app'
alias maps='open --new -a "Google Chrome" --args https://www.google.com/maps'
alias drive='open --new -a "Google Chrome" --args https://drive.google.com/drive/u/0/my-drive'
alias cal='open --new -a "Google Chrome" --args https://calendar.google.com/calendar/u/0/r'
#https://zwbetz.com/open-a-new-google-chrome-tab-or-window-via-command-line-on-mac/

# Nav Shortcuts
alias ......='cd ../../../../../'
alias .....='cd ../../../../'
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ../'

# Additional Nav Shortcuts!
#alias pyclean='find . | grep -E '(__pycache__|\.pyc|\.pyo$)' | xargs rm -rf'
alias flushdns='sudo killall -HUP mDNSResponder; sleep 2;'
alias mycode='cd /Volumes/Kr8tv/Users/Jaime/code'
alias me='cd /Volumes/Kr8tv/Users/Jaime/Desktop'
alias resetpyenv='pyenv local --unset'
alias setpyenv='pyenv local'

# BigQuery API Shortcuts
alias bqshow='bq show --format=prettyjson'
alias datasets='bq ls --format=pretty'

# GCP Cli Shortcuts
alias airreset='gcloud compute instances reset grow-with-the-flow'
alias switch='gcloud config configurations activate'
alias computes='gcloud compute instances list'
alias gconfigs='gcloud config configurations list'
alias gwtf='grow-with-the-flow'

# Quick-Commands
alias stoppg='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'
alias startpg='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'
alias update='pip install --upgrade . --use-feature=2020-resolver'
alias fixpsql='rm /usr/local/var/postgres/postmaster.pid'
alias sa='source ~/.oh-my-zsh/custom/aliases.zsh'
alias ea='subl ~/.oh-my-zsh/custom/aliases.zsh'
alias pgen='openssl rand -base64 20'
alias mkvenv='python3 -m venv venv'
alias spin='. venv/bin/activate'
alias jup='jupyter notebook'
alias szsh='source ~/.zshrc'
alias ezsh='subl ~/.zshrc'
alias dspin='deactivate'

# Command Shortcuts & Enhancements
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias mv='sudo mv -iv'                      # Preferred 'mv' implementation
alias rmv='sudo rm -r'
alias cp='sudo cp -iv'                      # Preferred 'cp' implementation
alias l='ls -CF'
alias la='ls -A'                            # List all files
alias c='clear'
alias copy='pbcopy'
alias p='pbpaste'

# Git Shortcuts
alias commit='git commit -m'
alias samecommit='git commit --amend --no-edit'
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
alias rprune='git remote prune origin'
#alias localprune='git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d'
alias submodules='git config --file .gitmodules --get-regexp path | awk '{ print $2 }''

# Airflow Shortcuts
alias restart='service airflow-webserver stop && service airflow-schedluer stop && git pull && sudo -H pip install --upgrade . && service airflow-webserver start && service airflow-schedluer start'
alias start='service airflow-webserver start && service airflow-schedluer start'
alias stop='service airflow-webserver stop && service airflow-schedluer stop'
alias growmachine='ssh -p 49 jaime.mendoza@34.89.145.127'
alias dev='ssh -p 22 jaime.mendoza@35.242.240.92'
alias aweb='airflow webserver'
alias sch='airflow scheduler'

