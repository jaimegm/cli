

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
    hacker-quotes
    dirhistory
    copypath
    history
    brew
    git
    )

export UPDATE_ZSH_DAYS=30             # Update Cycle
export LANG=en_US.UTF-8               # System Lanaguage
export ZSH=/Users/jaime/.oh-my-zsh
export CONFIG=/Users/jaime/config/cli
export tfenvironment=testing
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

# GCloud Path & Shell Completion
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jaime/google-cloud-sdk/path.zsh.inc' ]; 
  then . '/Users/jaime/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jaime/google-cloud-sdk/completion.zsh.inc' ]; 
  then . '/Users/jaime/google-cloud-sdk/completion.zsh.inc'; fi

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Service Account Credentials for GCP BigQuery
#export GOOGLE_APPLICATION_CREDENTIALS=/Users/jaime/creds/personal_gcp_service_account.json
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
# Postgres
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# PYENV Config
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
eval "$(pyenv init --path)"


##### Poetry Config #####
export PATH="/Users/jaime/.local/bin:$PATH"

eval "$(direnv hook zsh)"
source /Users/jaime/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /Users/jaime/.oh-my-zsh/themes/powerlevel10k/powerlevel10k.zsh-theme

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jaime/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jaime/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jaime/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jaime/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
