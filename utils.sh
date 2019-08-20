# Source: https://natelandau.com/bash-scripting-utilities/

# Install sudo apt-get install dos2unix
# Run dos2unix utils.sh

# Prompt-Color Selection
#bold=$(tput bold)
#underline=$(tput sgr 0 1)
#reset=$(tput sgr0)

#purple=$(tput setaf 171)
#red=$(tput setaf 1)
#green=$(tput setaf 76)
#tan=$(tput setaf 3)
#blue=$(tput setaf 38)

# Headers and  Logging
e_header() { printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@" 
}
e_arrow() { printf "➜ $@\n"
}
e_success() { printf "${green}✔ %s${reset}\n" "$@"
}
e_error() { printf "${red}✖ %s${reset}\n" "$@"
}
e_warning() { printf "${tan}➜ %s${reset}\n" "$@"
}
e_underline() { printf "${underline}${bold}%s${reset}\n" "$@"
}
e_bold() { printf "${bold}%s${reset}\n" "$@"
}
e_note() { printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
}

# Command-Completion Notification
# Must setup pushover account
pushover () {
  PUSHOVERURL="https://api.pushover.net/1/messages.json"
  API_KEY="your-api-here"
  USER_KEY="your-user-key-here"
  DEVICE=""

  TITLE="${1}"
  MESSAGE="${2}"

  curl \
  -F "token=${API_KEY}" \
  -F "user=${USER_KEY}" \
  -F "device=${DEVICE}" \
  -F "title=${TITLE}" \
  -F "message=${MESSAGE}" \
  "${PUSHOVERURL}" > /dev/null 2>&1
}
: '
recipes=(
  A-random-package
  bash
  Another-random-package
  git
)
list="$(to_install "${recipes[*]}" "$(brew list)")"
if [[ "$list" ]]; then
for item in ${list[@]}
  do
    echo "$item Needs to be Installed"
  done
else
e_arrow "Nothing to install.  Your ready to goo!"
fi
'

# Given a list of desired items and installed items, return a list
# of uninstalled items. Arrays in bash are insane (not in a good way).
# Credit: https://github.com/cowboy/dotfiles
#

function to_install() {
  local debug desired installed i desired_s installed_s remain
  if [[ "$1" == 1 ]]; then debug=1; shift; fi
    # Convert args to arrays, handling both space- and newline-separated lists.
    read -ra desired < <(echo "$1" | tr '\n' ' ')
    read -ra installed < <(echo "$2" | tr '\n' ' ')
    # Sort desired and installed arrays.
    unset i; while read -r; do desired_s[i++]=$REPLY; done < <(
      printf "%s\n" "${desired[@]}" | sort
    )
    unset i; while read -r; do installed_s[i++]=$REPLY; done < <(
      printf "%s\n" "${installed[@]}" | sort
    )
    # Get the difference. comm is awesome.
    unset i; while read -r; do remain[i++]=$REPLY; done < <(
      comm -13 <(printf "%s\n" "${installed_s[@]}") <(printf "%s\n" "${desired_s[@]}")
  )
  [[ "$debug" ]] && for v in desired desired_s installed installed_s remain; do
    echo "$v ($(eval echo "\${#$v[*]}")) $(eval echo "\${$v[*]}")"
  done
  echo "${remain[@]}"
}

function extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}