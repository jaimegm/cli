# Change namespace env var
function cname {
  export namespace="$1"
}

# Change environment env
function cenv {
  export tfenvironment="$1"
}

# Terraform Functions
function tfinit {
  terraform init -backend-config="prefix=$tfbackend-$tfenvironment" -reconfigure
}

function tfimport {
  terraform import -input=false -var-file="environments/production.tfvars" $1
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

function gservs {
  kubectl get services -n $namespace
}

function gdeps {
  kubectl get deployments -n $namespace
}

# Describe Pod
function dpod {
  kubectl describe pod -n $namespace $1
}

function dserve {
  kubectl describe service -n $namespace $1
}

function ddep {
  kubectl describe deployment -n $namespace $1
}

# Access Pod shell
function podshell {
  kubectl exec --stdin --tty $1 -n $namespace -- /bin/bash
}

# Get Pod Log
function podlog {
  kubectl logs -n $namespace $1
}

# Force remove pod
function fpod {
  kubectl delete pods -n $namespace $1 --grace-period=0 --force
}

# Remove Pod
function rmvpod {
  kubectl delete -n $namespace pods/$1
}

function podevnts {
  kubectl get event --namespace $namespace --field-selector involvedObject.name=$1
}

function cshell {
  docker exec -it $1 /bin/bash
}


function cleanpods {
  for pod in $(kubectl get pods --namespace $namespace | grep "Terminated" | awk '{print $1}'); kubectl delete -n $namespace pods/$pod; 
  for pod in $(kubectl get pods --namespace $namespace | grep "Completed" | awk '{print $1}'); kubectl delete -n $namespace pods/$pod;
  for pod in $(kubectl get pods --namespace $namespace | grep "Evicted" | awk '{print $1}'); kubectl delete -n $namespace pods/$pod; 
  for pod in $(kubectl get pods --namespace $namespace | grep "NodeShutdown" | awk '{print $1}'); kubectl delete -n $namespace pods/$pod; 
  for pod in $(kubectl get pods --namespace $namespace | grep "Error" | awk '{print $1}'); kubectl delete -n $namespace pods/$pod; 
  for pod in $(kubectl get pods --namespace $namespace | grep "ContainerStatusUnknown" | awk '{print $1}'); kubectl delete -n $namespace pods/$pod; 
  for pod in $(kubectl get pods --namespace $namespace | grep "OOMKilled" | awk '{print $1}'); kubectl delete -n $namespace pods/$pod; 

}

function get_bq_schema {
  bq show -format=prettyjson $1 | jq '.schema.fields' | pbcopy
}

function getsecret {
  gcloud secrets versions access latest --secret $1 | base64 -D > ~/config/secrets/$1.json
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
  sudo cp ~/.zshrc ~/config/cli/.zshrc && cd ~/config/cli && 
  # Create New Branch
  git checkout -b "$(echo "cli-sync")"-"$(prefix)" && 
  cd ~/config/cli & git add . && git commit -m "$(echo "auto-update")"-"$(openssl rand -hex 6)" &&
  # Push New Branch
  pbranch "$(git branch | grep '^\*' | cut -d' ' -f2)"

}

# get onepassword secret
function opget {
  op item get $1 --fields label=username,label=password --vault Private
}

function cleanport {
  for pid in $(lsof -i tcp:$1 | awk 'NR>1 {print $2}'); do echo "Killing process $pid"; kill $pid; done

}

function listversions {
  gcloud artifacts versions list \
  --package=$1 \
  --repository=seqana-python-repo \
  --location=europe-west3 \
  --project=gee-data-access
}

function dyt {
  yt-dlp -f "bestvideo+bestaudio" --merge-output-format mp4 "$1" -o .
}


function seqana-slack-me {
  curl -d "text=$1" -d "channel=$SLACK_MEMBER_ID" -H "Authorization: Bearer $SLACK_MESSAGE_SENDER_OAUTH_TOKEN" -X POST https://slack.com/api/chat.postMessage
}

function ak {
  poetry run python -m ipykernel install --user --name $(basename `git rev-parse --show-toplevel`) --display-name "$1"
}

function restore-gcs-file() {
    # Split the input argument (GCS file with generation) at the '#'
    local source_file=$1
    local destination_file=$(echo "$source_file" | cut -d '#' -f 1)

    # Copy the specific generation of the file back to its original path
    gsutil cp "$source_file" "$destination_file"
}

function get_user_permissions {
  # Temporary variable to store output
  output=""

  # Fetch the roles and append permissions to the output variable
  gcloud projects get-iam-policy gee-data-access \
    --flatten="bindings[].members" \
    --format="value(bindings.role)" \
    --filter="bindings.members:$1" | while read -r ROLE; do
    output+="Permissions for role: $ROLE\n"
    output+="$(gcloud iam roles describe "$ROLE" --format="json" | jq -r '.includedPermissions[]')\n\n"
  done

  # Print the result to console
  echo -e "$output"

  # Copy the result to clipboard (macOS: pbcopy, Linux: xclip)
  if command -v pbcopy &> /dev/null; then
    echo -e "$output" | pbcopy
  elif command -v xclip &> /dev/null; then
    echo -e "$output" | xclip -selection clipboard
  else
    echo "Clipboard command not found. Install pbcopy (macOS) or xclip (Linux) for clipboard support."
  fi
}
