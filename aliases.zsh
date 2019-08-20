# Alias Defintion File

# Directory Shortcuts
alias air='cd ~/code/ah_airflow_utils'
alias dags='cd ~/code/dags'
alias code='cd ~/code/'
alias home='cd ~/'

# Nav Shortcuts
alias .....='cd ../../../../'
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ../'

# Quick-Commands
alias vpn='cd ~/ && sudo openvpn client.ovpn'
alias update='pip install --upgrade .'
alias ezsh='subl ~/.zshrc'
alias szsh='source ~/.zshrc'
alias ealias='subl ~/.oh-my-zsh/custom/aliases.zsh'
alias salias='source ~/.oh-my-zsh/custom/aliases.zsh'
alias spin='. venv/bin/activate'
alias dspin='deactivate'

# Command Shortcuts & Enhancements
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# sleep 10; alert
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias la='ls -A'							# List all files
alias l='ls -CF'
alias c='clear'

# Git Shortcuts
alias clone='git clone'
alias pull='git pull'
alias push='git push'
alias gs='git status'

