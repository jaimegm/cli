apt install zsh 							# install ohmyZSH
sudo chsh -s /usr/bin/zsh root				# Make ZSH Default Shell

sudo apt install wget git  					# Install Git & wget Framework

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

sudo apt-get install python3.6

sudo apt-get install postgresql postgresql-contrib

: '
sudo -u postgres psql
psql -d airflow
sudo nano /etc/postgresql/10/main/pg_hba.conf 
sudo nano /etc/postgresql/10/main/postgresql.conf 
sudo service postgresql start
sudo service postgresqql reload

alias cpsql='psql -U postgres -h localhost'
'
