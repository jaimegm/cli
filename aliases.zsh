### Alias Defintion File ###
####--------------------####

# Directory Shortcuts
alias grow='cd ~/code/reference/grow_with_the_flow'
alias pred='cd /Users/jaime/code/predictors'
alias datab='cd /Users/jaime/code/target_database/databarn'
alias play='cd ~/code/playground'
alias ref='cd ~/code/reference'
alias down='cd ~/Downloads'
alias desk='cd ~/Desktop'
alias code='cd ~/code/'
alias home='cd ~/'
alias pychro='~/projects/pychronus'
alias pro='~/projects'
alias pvenvs='cd ~/Library/Caches/pypoetry/virtualenvs/'


# Seqana Repos
alias work='cd ~/code/seqana'
alias air='cd ~/code/seqana_dataflow'
alias targ='cd ~/code/target_database'
alias kosmos='cd ~/code/kosmos'

# Docker
alias dup='docker-compose up'
alias runc='docker run -it --entrypoint=/bin/sh'

# Chrome
alias chrome='open /Applications/Google\ Chrome.app'
alias maps='open --new -a "Google Chrome" --args https://www.google.com/maps'
alias drive='open --new -a "Google Chrome" --args https://drive.google.com/drive/u/0/my-drive'
alias cal='open --new -a "Google Chrome" --args https://calendar.google.com/calendar/u/0/r'
# https://zwbetz.com/open-a-new-google-chrome-tab-or-window-via-command-line-on-mac/

# Nav Shortcuts
alias ......='cd ../../../../../'
alias .....='cd ../../../../'
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ../'

# Additional Nav Shortcuts!
#alias pyclean='find . | grep -E '(__pycache__|\.pyc|\.pyo$)' | xargs rm -rf'
alias flushdns='sudo killall -HUP mDNSResponder; sleep 2;'
alias resetpyenv='pyenv local --unset'
alias abrew="/opt/homebrew/bin/brew"
alias ibrew="arch -x86_64 /usr/local/bin/brew"

# Petry Shortcuts
alias pu='poetry update'
alias pi='poetry install'
alias pr='poetry run'
alias prt='poetry run pytest --cov --cov-report html'

# BigQuery API Shortcuts
alias bqshow='bq show --format=prettyjson'
alias datasets='bq ls --format=pretty'

# GCP Cli Shortcuts
alias airreset='gcloud compute instances reset grow-with-the-flow'
alias switch='gcloud config configurations activate'
# gcloud container clusters get-credentials gcloud-project-id --region compute-network-region
alias computes='gcloud compute instances list'
alias gconfigs='gcloud config configurations list'
alias gsd='gcloud secrets delete'

# Quick-Commands
alias update='pip install --upgrade . --use-feature=2020-resolver'
alias fixpsql='rm /usr/local/var/postgres/postmaster.pid'
alias prefix='openssl rand -hex 6'

# Sublime Editor
# alias ef='subl ~/config/cli/functions.sh'
# alias ea='subl ~/config/cli/aliases.zsh'
# alias ep='subl ~/.zprofile'
# alias ezsh='subl ~/.zshrc'
# Pycharm editor
alias ea='pycharm ~/config/cli/aliases.zsh'
alias ef='pycharm ~/config/cli/functions.sh'
alias ep='pycharm ~/.zprofile'
alias ezsh='pycharm ~/.zshrc'
alias szsh='source ~/.zshrc'
alias cli='cd ~/config/cli'
alias config='cd ~/config'


alias kgs='kubectl get services -n'
# Quick-tools
alias pgen='openssl rand -base64 20'
alias mkvenv='python3 -m venv venv'
## DBT
alias drm="dbt run --models"
alias spin='. venv/bin/activate'
alias jup='jupyter notebook'

alias efunc="subl ~/config/cli/functions.sh"
alias dspin='deactivate'
alias sqlproxy='cloud-sql-proxy gee-data-access:europe-west3:production-seqana-database --port 5434 --credentials-file=/Users/jaime/config/secrets/seqana/seqana-cloud-sql-access-sa.json'

# Command Shortcuts & Enhancements
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias mv='sudo mv -iv'                      # Preferred 'mv' implementation
alias rmv='sudo rm -r'
alias cp='sudo cp -iv'                      # Preferred 'cp' implementation
alias l='ls -CF'
alias la='ls -A'                            # List all files
alias c='clear'
alias copy='pbcopy'
alias p='pbpaste'
alias back="cd \$OLDPWD"


# Git Shortcuts
alias oops='git reset --soft HEAD~1'
alias samecommit='git commit --amend --no-edit'
alias commit='git commit -m'
alias clone='git clone'
alias gc='git checkout'
alias add='git add'
alias pull='git pull'
alias push='git push'
alias gs='git status'
alias stash='git stash'
alias unstash='git stash pop'
alias nbranch='git checkout -b'
alias pbranch='git push --set-upstream origin'
alias snif='sudo netstat -ltnp | grep :'
alias rprune='git remote prune origin'
alias localprune='git branch -vv | grep ": gone]"|  grep -v "\*" | awk "{ print $1; }" | xargs -r git branch -D'
alias prea='pre-commit run --all-files'
alias unstage='git restore --staged'c
alias grc='git rebase --continue'
alias cleanbranches='git branch --merged >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'

alias pythos='ssh -p 22 pythonia@192.168.0.160'
alias octopi='ssh -p 22 pi@192.168.0.144'
# Change Credentials
alias gpythos='export GOOGLE_APPLICATION_CREDENTIALS=/Users/jaime/config/secrets/pythos-sa-jaime.json'
alias gwork='export GOOGLE_APPLICATION_CREDENTIALS=/Users/jaime/creds/personal_gcp_service_account.json'

# Airflow Shortcuts
alias restart='systemctl stop airflow-webserver && systemctl stop airflow-schedluer && git pull && poetry install && systemctl start airflow-webserver && systemctl start airflow-scheduler'
alias start='service airflow-webserver start && service airflow-schedluer start'
alias stop='service airflow-webserver stop && service airflow-schedluer stop'
alias growmachine='ssh -p 49 jaime.mendoza@34.89.145.127'
alias dev='ssh -p 22 jaime.mendoza@35.242.240.92'
alias aweb='airflow webserver'
alias sch='airflow scheduler'
alias aport='sudo lsof -i :8080'

# Terraform
alias tfix='terraform fmt -recursive'
alias tfapply='terraform apply -input=false tfplan'
# alias tfimport='terraform import -input=false -var-file="environments/testing.tfvars"'
alias tfimport='terraform import -input=false -var-file="environments/production.tfvars"'
alias tf-infra-test='terraform init -backend-config="prefix=data-infrastructure-testing" -reconfigure'
alias tfplan='terraform plan -out=tfplan -input=false -var-file="environments/production.tfvars"'
alias tf-infra-prod='terraform init -backend-config="prefix=data-infrastructure-production" -reconfigure'
alias tf-plan-test='terraform plan -out=tfplan -input=false -var-file="environments/testing.tfvars" -var-file="environments/terraform.tfvars"'
alias tf-plan-prod='terraform plan -out=tfplan -input=false -var-file="environments/production.tfvars" -var-file="environments/terraform.tfvars"'

# kubernetes
alias k8p='gcloud container clusters get-credentials production-k8s-cluster --region europe-west1'
alias k8t='gcloud container clusters get-credentials testing-k8s-cluster --region europe-west1'

# Blender
alias blender= '/Applications/Blender.app/Contents/MacOS/Blender'
