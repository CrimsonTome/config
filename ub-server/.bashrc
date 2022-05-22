# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export HISTSIZE=-1
export HISTFILESIZE=-1

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc



PS1=$"\w\n`whoami`💻`hostname`"$(tput blink)"-> "$(tput sgr0)


alias ls='ls -Alh --color=auto'
alias ai='sudo apt install'
alias aud='sudo apt update -y; sudo apt upgrade -y'
alias as='apt search'
alias ar='sudo apt remove'
alias aar='sudo apt autoremove'
alias gc='git clone' #clone a git repo
alias gpl='git pull' #pull updates from a git repo
alias gph='git push' #push local updates to a git repo
alias gl='git log' #check git log
alias ga='git add -A' #add all changes to commit
alias gs='git status' #check git status
alias ga='git add -A'
alias dfh='df -h' #disk space
alias dush='du -sh'

alias untar='tar -zxvf' #extract files from archive
alias ipe='curl ipinfo.io/ip' #check external ip address
alias c='clear' #clear terminal
alias words='wc -w' #check word count of a file
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
alias pullall='for i in */.git; do cd $(dirname $i); git pull -q; cd ..; done; echo done'
alias gzipc='gzip --keep -9' #max compression keeping the file
alias gitamendcomment='git commit --amend'
alias reboot='sudo reboot'
alias docker='sudo docker'

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

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
gitresettoremote() {
  read -p "Enter branch name: " branchname 
  git fetch origin
  git checkout $branchname
  git reset --hard origin/$branchname
  git clean -d --force
}
gitamendfiles() {
  git add . # or add individual files
  git commit --amend --no-edit
}
gittimemachine() {
  git reflog
  read -p "Enter index: " index
  # you will see a list of every thing you've
  # done in git, across all branches!
  # each one has an index HEAD@{index}
  # find the one before you broke everything
  git reset HEAD@{$index}
  # magic time machine
}
gitcloneorg() {
  read -p "Enter org name: " name
  GHORG={$name}; curl "https://api.github.com/orgs/$GHORG/repos?per_page=1000" | grep -o 'git@[^"]*' | xargs -L1 git clone

}

##-----------------------------------------------------
## synth-shell-greeter.sh
if [ -f /home/ctome/.config/synth-shell/synth-shell-greeter.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/ctome/.config/synth-shell/synth-shell-greeter.sh
fi

##-----------------------------------------------------
## synth-shell-prompt.sh
if [ -f /home/ctome/.config/synth-shell/synth-shell-prompt.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/ctome/.config/synth-shell/synth-shell-prompt.sh
fi

##-----------------------------------------------------
## alias
if [ -f /home/ctome/.config/synth-shell/alias.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/ctome/.config/synth-shell/alias.sh
fi

##-----------------------------------------------------
## better-history
if [ -f /home/ctome/.config/synth-shell/better-history.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/ctome/.config/synth-shell/better-history.sh
fi
