
if xcode-select -p > /dev/null; then
  echo "Core Xcode installed"
else
  xcode-select --install
fi

echo "Starting bootstrapping"


if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already Installed"
fi

PACKAGES=(
    1password-cli
    findutils
    postgresql
    python3
    python
    bash
    tree
    wget
    vim
    git
    zsh
    node
    jq
    direnv
    pyenv
    tfenv
    pipx
)

echo "Installing packages..."
if brew ls --versions ${PACKAGES[@]} > /dev/null; then
  echo " Installed ${PACKAGES[@]} "
else
  brew install ${PACKAGES[@]}
fi

pipx ensurepath

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


if [[ "$SHELL" != */zsh ]]; then
    echo "Zsh is not the default shell. Changing the default shell to Zsh..."

    # Check if Zsh is installed
    if ! command -v zsh &> /dev/null; then
        echo "Installing Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        echo "Zsh installed."
    fi

    # Change the default shell to Zsh
    # Ensure $(which zsh) is quoted to handle spaces in the path.
    chsh -s "$(which zsh)"
else
    echo "Zsh is already the default shell."
fi



echo "Installing fonts..."
brew tap homebrew/cask-fonts

echo "Downloading Terminal Hack Font..."
wget https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip

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


extract Hack-v3.003-ttf.zip

cp ttf/* /Library/Fonts/ && echo "Installed Fonts..."

rm -r ttf/
rm -r Hack-v3.003-ttf.zip

echo "Cleaning up...."

echo "Installing Python packages..."
PYTHON_PACKAGES=(
        sqlalchemy
        oauth2client
        google-api-python-client
        pandas
        python-dateutil
        google
        google-api-core
        pandas-gbq==0.10.0
        requests-oauthlib
)
sudo pipx install ${PYTHON_PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

ARCH=$(uname -m)

if [[ "$ARCH" == "arm64" ]]; then
    echo "Apple M1 chip detected."
    echo "Installing Google Cloud SDK..."
    curl https://sdk.cloud.google.com | bash
    source ~/.zshrc
    curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.8.2/cloud-sql-proxy.darwin.arm64
    chmod +x cloud-sql-proxy
elif [[ "$ARCH" == "x86_64" ]]; then
    echo "Intel chipset detected."
    ### Gcloud SDK ###
    if command -v gcloud >/dev/null 2>&1; then
        echo "Google Cloud SDK is already installed."
    else
        echo "Google Cloud SDK is not installed."
        # Optionally, prompt to install Google Cloud SDK
        read -p "Do you want to install Google Cloud SDK? (y/N) " answer
        if [[ $answer =~ ^[Yy]$ ]]; then
            # Assuming a Unix-like environment, adjust as needed for your OS
            # For example, on macOS you might use `brew install --cask google-cloud-sdk`
            # Below is the general installation script from Google
            echo "Installing Google Cloud SDK..."
            curl https://sdk.cloud.google.com | bash
            exec -l $SHELL
            gcloud init
        else
            echo "Google Cloud SDK installation skipped."
        fi
    fi
    ### Cloud SQL Proxy ###
    if command -v cloud-sql-proxy >/dev/null 2>&1; then
        echo "Cloud SQL Proxy is already installed."
    else
        echo "Installing Cloud SQL Proxy."
        curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.8.2/cloud-sql-proxy.darwin.amd64
        mv cloud-sql-proxy /usr/local/bin/
        sudo chmod +x /usr/local/bin/cloud-sql-proxy
    fi
else
    echo "Unknown architecture: $ARCH"
fi



sudo ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
sudo mv "MesloLGS NF Regular.ttf" /Library/Fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
sudo mv "MesloLGS NF Bold.ttf" /Library/Fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
sudo mv "MesloLGS NF Italic.ttf" /Library/Fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
sudo mv "MesloLGS NF Bold Italic.ttf" /Library/Fonts/

brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
cp .zshrc ~/

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

curl -sSL https://install.python-poetry.org | python3 - --version 1.2.0

echo "Bootstrapping complete"
