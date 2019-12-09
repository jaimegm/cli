# Setup
Extract File Types
https://github.com/xvoland/Extract/blob/master/extract.sh

# Install Plugins

git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Clone into /.oh-my-zsh/custom/themes/
git clone https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/awesomepanda.zsh-theme
git clone https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/sunrise.zsh-theme

# Make Shell Script Executable
chmod +x setup.sh

# Run Script
./setup.sh
