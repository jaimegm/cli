##### Poetry Config #####
export PATH="/Users/jaime/.local/bin:$PATH"

# PYENV Config
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
eval "$(pyenv init --path)"

# Add tfenv to PATH
export PATH="$HOME/.tfenv/bin:$PATH"

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# subl terminal link
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"

export GOOGLE_APPLICATION_CREDENTIALS=/Users/jaime/config/secrets/terraform_service_account-sa-key.json
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

export PKG_CONFIG_PATH="/usr/local/opt/mysql-client/lib/pkgconfig"

# MySQL-Client
export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"

# GCloud Path & Shell Completion
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.zsh.inc' ]; 
	then . '/usr/local/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/bin/google-cloud-sdk/completion.zsh.inc' ]; 
	then . '/usr/local/bin/google-cloud-sdk/completion.zsh.inc'; fi



