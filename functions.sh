# Change namespace env var
function en {
  export namespace="$1"
}

# Change environment env
function cenv {
  export tfenvironment="$1"
}

# Terraform Functions
function tfinit {
  terraform init -backend-config="prefix=$REPOSITORY-$tfenvironment" -reconfigure
}

function tfplan {
  terraform plan -out=tfplan -input=false -var-file="environments/$tfenvironment.tfvars"
}

# Kubeseal
function addsecret {
  kubectl create secret -n airflow generic airflow-production-helm-secrets --dry-run=client -o yaml --from-file='$1'='$1' | kubeseal --format yaml --cert ~/.kubeseal/$tfenvironment.pem --merge-into /Users/jaime/code/grow_with_the_flow/infrastructure/deployment/$tfenvironment/$tfenvironment-helm-secrets.yaml
}

# Terraform Build Commands
function build_service_account {
  echo '''
    resource "google_service_account" "'$1'_sa" {
      account_id  = "'$2'"
      description = "Add a Description"
    }

    resource "google_service_account_key" "'$1'_sa_key" {
      service_account_id = google_service_account.'$1'.name
    }

    resource "google_secret_manager_secret" "'$1'_sa_key_secret" {
      provider  = google-beta
      secret_id = "'$2'-sa-key"

      labels = {
        users = "data_team"
      }

      replication {
        automatic = true
      }
    }

    resource "google_secret_manager_secret_version" "'$1'_sa_key_secret" {
      provider    = google-beta
      secret      = google_secret_manager_secret.'$1'_sa_key_secret.id
      secret_data = google_service_account_key.'$1'_sa_key.private_key
    }

    '''
}

# Get Pods
function gpods {
  kubectl get pods -n $namespace
}

# Describe Pod
function dpod {
  kubectl describe pod -n $namespace '$1'
}

# Access Pod shell
function podshell {
  kubectl exec --stdin --tty '$1' -n $namespace -- /bin/bash
}

# Get Pod Log
function podlog {
  kubectl logs -n $namespace '$1'
}

# Force remove pod
function fpod {
  kubectl delete pods -n $namespace '$1' --grace-period=0 --force
}

# Remove Pod
function rmvpod {
  kubectl delete -n $namespace pods/'$1'
}

function podevnts {
  kubectl get event --namespace $namespace --field-selector involvedObject.name='$1'
}



function cleanpods {
  for pod in $(kubectl get pods --namespace $namespace | grep "Terminated" | awk '{print '$1'}'); kubectl delete -n $namespace pods/$pod; 
  for pod in $(kubectl get pods --namespace $namespace | grep "Completed" | awk '{print '$1'}'); kubectl delete -n $namespace pods/$pod;
  for pod in $(kubectl get pods --namespace $namespace | grep "Evicted" | awk '{print '$1'}'); kubectl delete -n $namespace pods/$pod; 
  for pod in $(kubectl get pods --namespace $namespace | grep "NodeShutdown" | awk '{print '$1'}'); kubectl delete -n $namespace pods/$pod; 
  for pod in $(kubectl get pods --namespace $namespace | grep "Error" | awk '{print '$1'}'); kubectl delete -n $namespace pods/$pod; 

}

function get_bq_schema {
  bq show -format=prettyjson '$1' | jq '.schema.fields' | pbcopy
}

function download_secret {
  gcloud secrets versions access latest --secret '$1' | base64 -D > ~/creds/'$1'.json
}

function extract {
 if [ -z "'$1'" ]; then
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

# capture the output of a command so it can be retrieved with ret
cap () { tee /tmp/capture.out; }

# return the output of the most recent command that was captured by cap
ret () { cat /tmp/capture.out; }

# Auto update CLI Repo
function syncli {
  # Copy recent .zshrc changes
  sudo cp .zshrc ~/config/cli/.zshrc && cd ~/config/cli && 
  # Create New Branch
  git checkout -b "$(echo "cli-sync")"-"$(prefix)" && 
  cd ~/config/cli & git add . && git commit -m "$(echo "auto-update")"-"$(openssl rand -hex 6)" &&
  # Push New Branch
  pbranch "$(git branch | grep '^\*' | cut -d' ' -f2)"

}