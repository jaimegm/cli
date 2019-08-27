# Alias Defintion File

# Directory Shortcuts
alias air='cd ~/code/ah_airflow_utils'
alias dags='cd ~/code/dags'
alias code='cd ~/code/'
alias home='cd ~/'
alias desk='cd ~/Desktop'
alias docs='cd ~/Documents'
alias down='~/Downloads'

# Nav Shortcuts
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ../'

# Quick-Commands
alias vpn='cd ~/ && sudo openvpn client.ovpn'
alias update='pip install --upgrade .'
alias ezsh='sudo subl ~/.zshrc'
alias szsh='source ~/.zshrc'
alias ea='sudo subl ~/.oh-my-zsh/custom/aliases.zsh'
alias sa='source ~/.oh-my-zsh/custom/aliases.zsh'
alias spin='. venv/bin/activate'
alias dspin='deactivate'
#alias history='history -E'
alias jup='jupyter notebook'

# Command Shortcuts & Enhancements
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# sleep 10; alert
alias la='ls -A'							# List all files
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
