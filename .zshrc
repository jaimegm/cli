
# Path to your oh-my-zsh installation.
# export ZSH=/home/jaime/.oh-my-zsh         # ZSH Home
export UPDATE_ZSH_DAYS=30             # Update Cycle
export LANG=en_US.UTF-8               # System Lanaguage
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "awesomepanda" "solarized-powerline" )
# Terminal Behaviour
HYPHEN_INSENSITIVE=true     # Make - & _ Interchangeable
ENABLE_CORRECTION=true      # Enable Auto-Correction
COMPLETION_WAITING_DOTS=true    # Completion Waiting Dots
##############################################################################
# History Configuration
##############################################################################
HIST_STAMPS=mm/dd/yyyy
HISTSIZE=50000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=10000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
#setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed
# Would you like to use another custom folder than /custom?
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
source ~/.oh-my-zsh/custom/aliases.zsh
 
