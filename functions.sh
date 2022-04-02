function addsecret {
  kubectl create secret -n airflow generic airflow-production-helm-secrets --dry-run=client -o yaml --from-file=$1=$1 | kubeseal --format yaml --cert ~/.kubeseal/production.pem --merge-into /Users/jaime/code/grow_with_the_flow/infrastructure/deployment/helm/production-helm-secrets.yaml
}

function gpods {
  kubectl get pods -n $namespace
}

function dpod {
  kubectl describe pod -n $namespace $1
}

function podshell {
  kubectl exec --stdin --tty $1 -n $namespace -- /bin/bash
}

function podlog {
  kubectl logs -n $namespace $1
}

function rmvpod {
  kubectl delete -n $namespace pods/$1
}

function cleanpods {
  for pod in $(kubectl get pods --namespace $namespace | grep $1 | awk '{print $1}'); kubectl delete -n $namespace pods/$pod
}

# function rmv_shutdown_pods {
#   for pod in $(kubectl get pods --namespace $1 | grep Shutdown | awk '{print $1}'); kubectl delete -n $1 pods/$pod
# }

# function rmv_terminated_pods {
#   for pod in $(kubectl get pods --namespace $1 | grep Terminated | awk '{print $1}'); kubectl delete -n $1 pods/$pod
# }

function get_bq_schema {
  bq show -format=prettyjson $1 | jq '.schema.fields' | pbcopy
}

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