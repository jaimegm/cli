##############################################################################
########################   History Configuration   ###########################
##############################################################################

[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=50000              #  How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #  Where to save history to disk
SAVEHIST=10000              #  Number of history entries to save to disk
HISTDUP=erase               #  Erase duplicates in the history file
setopt appendhistory        #  Append history
#setopt sharehistory         #  Share history across terminals
setopt incappendhistory     #  Immediate append
setopt extendedhistory      #  Attach timestamps


###### ZSH THEME ########
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-patched"

##### ZSH Plugins #######
plugins=(
    dirhistory
    copypath
    history
    )

export UPDATE_ZSH_DAYS=30             # Update Cycle
export LANG=en_US.UTF-8               # System Lanaguage
export ZSH=$HOME/.oh-my-zsh
export CONFIG=$HOME/config/cli
export tfenvironment=testing
source ~/.zprofile
source $CONFIG/functions.sh
source $CONFIG/converter_tools.sh
source $CONFIG/aliases.zsh
source $ZSH/oh-my-zsh.sh
#source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# P10K Prompt
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

##### Terminal Behaviour #####
HYPHEN_INSENSITIVE=true         # Make - & _ Interchangeable
ENABLE_CORRECTION=true          # Enable Auto-Correction
COMPLETION_WAITING_DOTS=true    # Completion Waiting Dots

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jaime/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jaime/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jaime/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jaime/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/usr/local/opt/mysql-client/bin:$PATH"

export SEQANA_PYTHON_REPO_PASSWORD=$(op read op://engineering/seqana-python-repo/password)
export SEQANA_PYTHON_REPO_USERNAME=$(op read op://engineering/seqana-python-repo/username)
