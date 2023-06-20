# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
#setopt incappendhistory     #  Immediate append
setopt extendedhistory      #  Attach timestamps


###### ZSH THEME ########
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-patched"

##### ZSH Plugins #######
plugins=(
    zsh-syntax-highlighting
    #hacker-quotes
    dirhistory
    copypath
    history
    brew
    git
    )

export UPDATE_ZSH_DAYS=30             # Update Cycle
export LANG=en_US.UTF-8               # System Lanaguage
export ZSH=$HOME/.oh-my-zsh
export CONFIG=$HOME/config/cli
export tfenvironment=testing
source ~/.zprofile
source $CONFIG/functions.sh
source $CONFIG/aliases.zsh
source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# P10K Prompt
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

##### Terminal Behaviour #####
HYPHEN_INSENSITIVE=true         # Make - & _ Interchangeable
ENABLE_CORRECTION=true          # Enable Auto-Correction
COMPLETION_WAITING_DOTS=true    # Completion Waiting Dots

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# 1password login
eval $(security find-generic-password -a jaime.m@seqana.com -w | op signin --account seqana.1password.eu)
export PATH="/opt/homebrew/bin:$PATH"


### Direnv ###
eval "$(direnv hook zsh)"
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

