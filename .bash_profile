# HISTORY FILE SETTINGS	
export HISTIGNORE="ls:ps:history"  					# Ignore thes commands in History File
HISTTIMEFORMAT="%h %d %H:%M:%S"						# Add timestamp information to history file
#HISTCONTROL=ignoreboth								# Don't duplicate lines or lines starting with space in the history.
shopt -s histappend 								# Append commands to History instead of overwrite
HISTFILESIZE=20000 									# History file size
HISTSIZE=10000 										# History command length
shopt -s cmdhist 									# Store multi-line commands as single line

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
