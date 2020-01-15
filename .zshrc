export UPDATE_ZSH_DAYS=30             # Update Cycle
export LANG=en_US.UTF-8               # System Lanaguage

# Path to your oh-my-zsh installation.
export ZSH="/Users/jaime/.oh-my-zsh"
PATH=$PATH:/usr/local/bin/; export PATH

##### THEME Config #######
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="awesome-patched"

# Terminal Behaviour
HYPHEN_INSENSITIVE=true     # Make - & _ Interchangeable
ENABLE_CORRECTION=true      # Enable Auto-Correction
COMPLETION_WAITING_DOTS=true    # Completion Waiting Dots

# Plugin Configuration
plugins=(
    #zsh-syntax-highlighting
    #zsh-autosuggestions
    brew
    osx
    git
    )

source ~/.oh-my-zsh/custom/aliases.zsh
source $ZSH/oh-my-zsh.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jaime/google-cloud-sdk/path.zsh.inc' ];
then . '/Users/jaime/google-cloud-sdk/path.zsh.inc'; fi

# Shell completion for gcloud.
if [ -f '/Users/jaime/google-cloud-sdk/completion.zsh.inc' ];
then . '/Users/jaime/google-cloud-sdk/completion.zsh.inc'; fi

# PYenv Config
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

#Poetry Config
#source $HOME/.poetry/env

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


##############################################################################
# History Configuration
##############################################################################
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=50000              #  How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #  Where to save history to disk
SAVEHIST=10000              #  Number of history entries to save to disk
HISTDUP=erase               #  Erase duplicates in the history file
setopt appendhistory        #  Append history
setopt sharehistory         #  Share history across terminals
setopt incappendhistory     #  Immediate append
setopt extendedhistory      #  Attach timestamps

#####################
#### FUNCTIONS ######
#####################

SAVEIFS=$IFS
IFS="$(printf '\n\t')"

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *.zpaq)      zpaq x ./"$n"      ;;
            *.arc)         arc e ./"$n"       ;;
            *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                              extract $n.iso && \rm -f $n ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS
source /Users/jaime/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/jaime/code/wegwarte/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/jaime/code/wegwarte/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/jaime/code/wegwarte/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/jaime/code/wegwarte/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/jaime/code/wegwarte/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/jaime/code/wegwarte/node_modules/tabtab/.completions/slss.zsh

export GOOGLE_APP_ENGINE_DIR=/usr/local/google_appengine
# Service Account Credentials for GCP BigQuery
export GOOGLE_APPLICATION_CREDENTIALS=/Users/jaime/creds/infarm-data-airflow-c22b7153b8cd.json

# Data directory to save results to
export DATA_DIR=/Users/jaime/code/playground

# Pyenv build configs
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"


export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
eval "$(pyenv init -)"
