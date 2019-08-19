
# Util Scripts
source $HOME/utils.sh

# Script Configurations
#e_header "I am a sample script"
#e_success "Dream it, Wish it, Do it!!!"
#e_error "If at first you don't succeed, Try, Try Again!"
#e_warning "Proceed With Caution"
#e_underline "I am underlined text"
#e_bold "I am bold text"
#e_note "I am a note"

# HISTORY FILE SETTINGS	
xport HISTIGNORE="ls:ps:history"  					# Ignore thes commands in History File
HISTTIMEFORMAT="%h %d %H:%M:%S"						# Add timestamp information to history file
PROMPT_COMMAND='history -a' 						# Save Command instantly, instead after successful session
HISTCONTROL=ignoreboth								# Don't duplicate lines or lines starting with space in the history.
shopt -s histappend 								# Append commands to History instead of overwrite
HISTFILESIZE=20000 									# History file size
HISTSIZE=10000 										# History command length
shopt -s cmdhist 									# Store multi-line commands as single line

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

