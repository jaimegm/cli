
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
    zsh-syntax-highlighting
    hacker-quotes
    dirhistory
    copydir
    history
    brew
    git
    )

export UPDATE_ZSH_DAYS=30             # Update Cycle
export LANG=en_US.UTF-8               # System Lanaguage
export ZSH=/Users/jaime/.oh-my-zsh
export CONFIG=/Users/jaime/config/cli
source $CONFIG/functions.sh
source $ZSH/custom/aliases.zsh
source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# P10K Prompt
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

##### Terminal Behaviour #####
HYPHEN_INSENSITIVE=true         # Make - & _ Interchangeable
ENABLE_CORRECTION=true          # Enable Auto-Correction
COMPLETION_WAITING_DOTS=true    # Completion Waiting Dots

# GCloud Path & Shell Completion
if [ -f '/Users/jaime/google-cloud-sdk/path.zsh.inc' ]; 
  then . '/Users/jaime/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/jaime/google-cloud-sdk/completion.zsh.inc' ]; 
  then . '/Users/jaime/google-cloud-sdk/completion.zsh.inc'; fi

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Service Account Credentials for GCP BigQuery
export GOOGLE_APPLICATION_CREDENTIALS=/Users/jaime/creds/infarm-data-airflow-c22b7153b8cd.json

export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
# Postgres
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# PYENV Config
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

##### Poetry Config #####
source $HOME/.poetry/env
export PATH="$HOME/.poetry/bin:$PATH"
