#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -Al --color=auto'

#sets the prompt to the userame@hostname with the full working directory, starts a newline for the command to be on
PS1=$"\w\n💻"$(tput blink)"-> "$(tput sgr0)

########
#ALCI
########
alias evb='sudo systemctl enable --now vboxservice.service'
#######

#user aliases
#some adapted from sbrl's bash aliases

#comments should probably be added here

alias pi='sudo pacman -S' #installs a package
alias pu='sudo pacman -Syu' #updates the system
alias pr='sudo pacman -Rns' #removes a package and all it's dependencies that aren't needed by other packages
alias ps='pacman -Ss' #package search
alias psi='pacman -Qi' #info about an installed package
alias psd='pacman -Sii' #info about list-installed package and its dependencies
alias pls='pacman -Qeq' #list pacman packages explicitly installed
alias aurls='pacman -Qmq' #list aur packages
alias yu='yay -Sua' #updates aur packages
alias yi='yay -S' #installs an aur package
alias yr='yay -Rns' #removes an aur package
alias pcc='sudo pacman -Sc' #clear package cache except installed packages (only do if in need of space)
alias pccc='pacman -Scc' #clear ALL of the package cache (ONLY DO IF IN NEED OF SERIOUS SPACE)
alias gc='git clone' #clone a git repo
alias gpl='git pull' #pull updates from a git repo
alias gph='git push' #push local updates to a git repo
alias gl='git log' #check git log
alias gac='git commit -am' #adds all changes to commit and add a comment 
alias gs='git status' #check git status
alias untar='tar -zxvf' #extract files from archive
alias ipe='curl ipinfo.io/ip' #check external ip address
alias c='clear' #clear terminal
alias words='wc -w' #check word count of a file
alias yt='yt-dlp' #download a YT video
alias mp3='yt-dlp -x --audio-format mp3' #grab the mp3 of a YT video
alias eb='clear && exec bash' #reload bash and clear the terminal screen
alias back='cd -' #go back to the directory you were in previously (should probably add some pushd stuff here)
# -v adds verbosity, -i makes it interactive 
alias mkdir='mkdir -pv' #make a directory allowing for layering e.g. mkdir foo/bar/  
alias rm='rm -vi' #remove file
alias rmr='rm -rv' #remove recursively 
alias rmdir='rmdir -v' #remove directory
alias cp='cp -vi'  #copy 
alias cpdir='cp -vr' #copy directory and contents
alias mv='mv -vi' #move
alias upstats='echo "Up since:" && uptime -s && uptime -p' #displays uptime stats 
alias sshserver='mosh root@192.168.100.2' #ssh's into my server 
alias restartwifi='sudo systemctl restart iwd.service' #restarts the WiFi service, it can be a bit weird on Arch, this sometimes helps
alias sudo='sudo -p "$(printf "\033[1;31mPassword: \033[0;0m" )"' 
#end of manual aliases

#user functions
up () { #goes up x directories
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

# from https://github.com/dylanaraps/pure-bash-bible/blob/master/README.md

bkr() { #runs a command in the background 
    (nohup "$@" &>/dev/null &)
}

trim_all() { #trim all y from string x
    # Usage: trim_all "   example   string    "
    set -f
    set -- $*
    printf '%s
' "$*"
    set +f
}

split() { #split a string based on a delimiter
   # Usage: split "string" "delimiter"
   IFS=$'
' read -d "" -ra arr <<< "${1//$2/$'
'}"
   printf '%s
' "${arr[@]}"
}

lower() { #convert to lowercase
    # Usage: lower "string"
    printf '%s
' "${1,,}"
}

upper() { #convert to uppercase
    # Usage: upper "string"
    printf '%s
' "${1^^}"
}

reverse_case() { #reverse the case of a string
    # Usage: reverse_case "string"
    printf '%s
' "${1~~}"
}

strip_all() { #strp all y from x
    # Usage: strip_all "string" "pattern"
    printf '%s
' "${1//$2}"
}

lines() { #show line count of file
    # Usage: lines "file"
    mapfile -tn 0 lines < "$1"
    printf '%s
' "${#lines[@]}"
}

lspkg() { #list packages in interactive format
  pacman -Qeq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}

rmo() 	{ #remove orphans
 sudo pacman -Qtdq |sudo pacman -Rns -
}
# end of user functions

#startup commands

PF_INFO="ascii title os host kernel uptime shell wm de" pfetch|lolcat #displays sysem info on bash startup

# kdesrc-build #################################################################

## Add kdesrc-build to PATH
export PATH="$HOME/kde/src/kdesrc-build:$PATH"


## Autocomplete for kdesrc-run
function _comp_kdesrc_run
{
  local cur
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"

  # Complete only the first argument
  if [[ $COMP_CWORD != 1 ]]; then
    return 0
  fi

  # Retrieve build modules through kdesrc-run
  # If the exit status indicates failure, set the wordlist empty to avoid
  # unrelated messages.
  local modules
  if ! modules=$(kdesrc-run --list-installed);
  then
      modules=""
  fi

  # Return completions that match the current word
  COMPREPLY=( $(compgen -W "${modules}" -- "$cur") )

  return 0
}

## Register autocomplete function
complete -o nospace -F _comp_kdesrc_run kdesrc-run

################################################################################
