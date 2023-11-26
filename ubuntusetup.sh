sudo apt install -y zsh wget git ufw
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
zsh

sudo chsh -s $(which zsh)

# Setup firewall
sudo ufw allow ssh
sudo ufw allow 22
sudo ufw allow http
sudo ufw allow https

### Install Docker ###
sudo apt update
# prerequisite packages which let apt use packages over HTTPS
sudo apt install apt-transport-https ca-certificates curl software-properties-common
# Then add the GPG key for the official Docker repository to your system:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# Add the Docker repository to APT sources:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu xenial stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce

### Install Docker-Compose ###
sudo apt update
sudo apt install docker-compose
docker-compose --version

### Install Nginx ###
sudo apt install nginx

### Install Certbot ###
#sudo apt install certbot python3-certbot-nginx