
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
 
