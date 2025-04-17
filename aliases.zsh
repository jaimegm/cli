### Alias Defintion File ###
####--------------------####

# Directory Shortcuts
alias grow='cd ~/code/reference/grow_with_the_flow'
alias datab='cd /Users/jaime/code/target_database/databarn'
alias play='cd ~/code/playground'
alias ref='cd ~/code/reference'
alias desk='cd ~/Desktop'
alias code='cd ~/code/'
alias home='cd ~/'
alias pvenvs='cd ~/Library/Caches/pypoetry/virtualenvs/'

# Nav Shortcuts
alias ......='cd ../../../../../'
alias .....='cd ../../../../'
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ../'

# Seqana Repos
alias pred='cd /Users/jaime/work/predictors'
alias targ='cd ~/work/target_database'
alias air='cd ~/work/seqana_dataflow'
alias kosmos='cd ~/work/kosmos'
alias work='cd ~/work'
alias down='cd ~/Downloads'
alias orbis='cd /Users/jaime/work/orbis'
alias opsign='eval $(security find-generic-password -a jaime.m@seqana.com -w | op signin --account seqana.1password.eu)'

# Docker
alias dup='docker-compose up'
alias runc='docker run -it --entrypoint=/bin/sh'

# Poetry Shortcuts
alias pu='poetry update'
alias pi='poetry install'
alias pr='poetry run'
alias prt='poetry run pytest --cov --cov-report html'

# Pycharm editor
alias ea='pycharm ~/config/cli/aliases.zsh'
alias ef='pycharm ~/config/cli/functions.sh'
alias ep='pycharm ~/.zprofile'
alias ezsh='pycharm ~/.zshrc'
alias szsh='source ~/.zshrc'
alias cli='cd ~/config/cli'
alias config='cd ~/config'

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
alias dbranch='git branch -D'
alias prea='poetry run pre-commit run --all-files'
alias gcm='git checkout main'
alias mainresolve='git rebase main -X theirs'
alias resetfile='git rebase main -X theirs'

alias lcompute='gcloud compute instances list'
alias scompute='gcloud compute instances start'
alias kcompute='gcloud compute instances stop'
alias sshc='gcloud compute ssh --zone europe-west3-b'

# Chrome
alias chrome='open /Applications/Google\ Chrome.app'
alias maps='open --new -a "Google Chrome" --args https://www.google.com/maps'
alias drive='open --new -a "Google Chrome" --args https://drive.google.com/drive/u/0/my-drive'
alias cal='open --new -a "Google Chrome" --args https://calendar.google.com/calendar/u/0/r'
# https://zwbetz.com/open-a-new-google-chrome-tab-or-window-via-command-line-on-mac/
#alias opsign='eval $(security find-generic-password -a jaime.m@seqana.com -w | op signin --account seqana.1password.eu)'

# Additional Nav Shortcuts!
#alias pyclean='find . | grep -E '(__pycache__|\.pyc|\.pyo$)' | xargs rm -rf'
alias flushdns='sudo killall -HUP mDNSResponder; sleep 2;'
alias resetpyenv='pyenv local --unset'
alias abrew="/opt/homebrew/bin/brew"
alias ibrew="arch -x86_64 /usr/local/bin/brew"
alias pychro='~/code/pychronus'

# BigQuery API Shortcuts
alias bqshow='bq show --format=prettyjson'
alias datasets='bq ls --format=pretty'

# GCP Cli Shortcuts
alias airreset='gcloud compute instances reset grow-with-the-flow'
alias switch='gcloud config configurations activate'
alias gsd='gcloud secrets delete'
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


alias kgs='kubectl get services -n'
# Quick-tools
alias pgen='openssl rand -base64 20'
alias mkvenv='python3 -m venv venv'
## DBT
alias drm="dbt run --models"
alias spin='. venv/bin/activate'
alias jup='jupyter notebook'
alias dspin='deactivate'
alias sqlproxy='cloud-sql-proxy gee-data-access:europe-west3:production-seqana-database --port 5434 --credentials-file=/Users/jaime/config/secrets/seqana/terraform_service_account-sa-key.json'

# Command Shortcuts & Enhancements
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
#alias mv='mv -iv'                      # Preferred 'mv' implementation
alias rmv='sudo rm -r'
#alias cp='cp -iv'                      # Preferred 'cp' implementation
alias l='ls -CF'
alias la='ls -A'                            # List all files
alias c='clear'
alias copy='pbcopy'
alias p='pbpaste'
alias back="cd \$OLDPWD"



alias checkn='sudo arp-scan --interface=en0 --localnet'
alias snif='sudo netstat -ltnp | grep :'
alias rprune='git remote prune origin'
alias localprune='git branch -vv | grep ": gone]"|  grep -v "\*" | awk "{ print $1; }" | xargs -r git branch -D'
alias unstage='git restore --staged'
alias grc='git rebase --continue'
alias cleanbranches='git branch --merged >/tmp/merged-branches && vi /tmp/merged-branches && xargs git branch -d </tmp/merged-branches'

#alias pythos='ssh -p 22 jaime@192.168.0.160'
alias pythos='ssh jaime@192.168.0.160'
alias octopi='ssh -p 22 jaime@192.168.0.144'
# Change Credentials
alias gpythos='export GOOGLE_APPLICATION_CREDENTIALS=/Users/jaime/config/secrets/pythos-sa-jaime.json'
alias gwork='export GOOGLE_APPLICATION_CREDENTIALS=/Users/jaime/creds/personal_gcp_service_account.json'

# Airflow Shortcuts
alias restart='systemctl stop airflow-webserver && systemctl stop airflow-schedluer && git pull && poetry install && systemctl start airflow-webserver && systemctl start airflow-scheduler'
alias start='service airflow-webserver start && service airflow-schedluer start'
alias stop='service airflow-webserver stop && service airflow-schedluer stop'
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
alias checksysdata='sudo true; prev_line=""; while read -r line; do [[ $(echo "$prev_line" | grep -o "$(echo $line | awk '"'"'{print $NF}'"'"')") ]] || echo "====================="; echo "$line"; prev_line="$line"; done < <(sudo du -hd1000 ~ | grep -E "G\t")'

