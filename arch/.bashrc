#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -Al --color=auto'

#sets the prompt to the userame@hostname with the full working directory, starts a newline for the command to be on
PS1="[35m\u@\h~$ 
\w"$(tput setaf 2)" "$(tput blink)" > "$(tput sgr0)" [m"

########
#ALCI
########
alias evb='sudo systemctl enable --now vboxservice.service'
#######


#user aliases
#some adapted from sbrl's bash aliases
alias pi='sudo pacman -S'
alias pu='sudo pacman -Syu'
alias gc='git clone'
alias gpl='git pull'
alias gph='git push'
alias gl='git log'
alias gac='git commit -am'
alias gs='git status'
alias untar='tar -zxvf'
alias ipe='curl ipinfo.io/ip'
alias c='clear'
alias words='wc -w'
alias yt='youtube-dl'
alias mp3='youtube-dl -x --audio-format mp3'
alias eb='clear && exec bash'
alias back='cd -'
alias mkdir='mkdir -pv'
alias rm='rm -vi'
alias rmr='rm -rv'
alias rmdir='rmdir -vi'
alias cp='cp -vi'
alias mv='mv -vi'
alias upstats='echo "Up since:" && uptime -s && uptime -p'
alias sshserver='ssh root@192.168.100.2'
alias restartwifi='sudo systemctl restart iwd.service'
#end of manual aliases


#user functions
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

#### from https://github.com/dylanaraps/pure-bash-bible/blob/master/README.md

bkr() {
    (nohup "$@" &>/dev/null &)
}

bkr ./some_script.sh # some_script.sh is now running in the background

trim_all() {
    # Usage: trim_all "   example   string    "
    set -f
    set -- $*
    printf '%s\n' "$*"
    set +f
}

split() {
   # Usage: split "string" "delimiter"
   IFS=$'\n' read -d "" -ra arr <<< "${1//$2/$'\n'}"
   printf '%s\n' "${arr[@]}"
}

lower() {
    # Usage: lower "string"
    printf '%s\n' "${1,,}"
}

upper() {
    # Usage: upper "string"
    printf '%s\n' "${1^^}"
}

reverse_case() {
    # Usage: reverse_case "string"
    printf '%s\n' "${1~~}"
}

strip_all() {
    # Usage: strip_all "string" "pattern"
    printf '%s\n' "${1//$2}"
}

lines() {
    # Usage: lines "file"
    mapfile -tn 0 lines < "$1"
    printf '%s\n' "${#lines[@]}"
}
# end of user functions

#startup commands

PF_INFO="ascii title os host kernel uptime pkgs memory shell editor wm de" pfetch|lolcat

