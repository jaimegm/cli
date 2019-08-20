# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/jaime/.oh-my-zsh"					# ZSH Home
export UPDATE_ZSH_DAYS=30							# Update Cycle
export LANG=en_US.UTF-8								# System Lanaguage

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME=random
ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# HISTORY FILE SETTINGS	
export HISTIGNORE="ls:ps:history"  					# Ignore thes commands in History File
HISTTIMEFORMAT="%h %d %H:%M:%S"						# Add timestamp information to history file
PROMPT_COMMAND='history -a' 						# Save Command instantly, instead after successful session
HISTCONTROL=ignoreboth								# Don't duplicate lines or lines starting with space in the history.
setopt -s histappend 								# Append commands to History instead of overwrite
HISTFILESIZE=20000 									# History file size
HISTSIZE=10000 										# History command length
setopt -s cmdhist 									# Store multi-line commands as single line

# Terminal Behaviour
HYPHEN_INSENSITIVE="true"			# Make - & _ Interchangeable
ENABLE_CORRECTION="true"			# Enable Auto-Correction
COMPLETION_WAITING_DOTS="true"		# Completion Waiting Dots

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Plugin Configuration
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
