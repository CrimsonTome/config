#!/usr/bin/env bash

# Bash aliases and functions

#if helix is installed, alias vim to it 
if which hx >/dev/null 2>&1; then
    alias vim='hx';
fi

alias q='exit'

#if lsd is installed alias ls to it
if which ls >/dev/null 2>&1; then
    alias ls='lsd -lrthA'
fi

# dnf aliases
alias di='sudo dnf install'
alias dud='sudo dnf update -y'
alias ds='dnf search'
alias dr='sudo dnf remove'
alias dar='sudo dnf autoremove'
alias dli='dnf list installed'
alias dlu='dnf history userinstalled'

# git aliases
alias gc='git clone' #clone a git repo
alias gpl='git pull' #pull updates from a git repo
alias gph='git push' #push local updates to a git repo
alias gl='git log' #check git log
# commit is a script that makes sure I follow conventional commits
if [ -f $HOME/bin/commit ] ; then
	alias gcm='commit'
fi
alias gs='git status' #check git status
alias gr='git remote -v'
alias gitamendcomment='git commit --amend'

# should extract to a function
alias pullall='for i in */.git; do cd $(dirname $i); git pull -q; cd ..; done; echo done'

# git functions
gitresettoremote() {
  read -rp "Enter branch name: " branchname 
  git fetch origin
  git checkout "$branchname"
  git reset --hard origin/"$branchname"
  git clean -d --force
}
gitamendfiles() {
  git add . # or add individual files
  git commit --amend --no-edit
}
gittimemachine() {
  git reflog
  read -rp "Enter index: " index
  # you will see a list of every thing you've
  # done in git, across all branches!
  # each one has an index HEAD@{index}
  # find the one before you broke everything
  git reset HEAD@"$index"
  # magic time machine
}
gitcloneorg() {
  read -rp "Enter org name: " name
  GHORG="$name"; curl "https://api.github.com/orgs/$GHORG/repos?per_page=1000" | grep -o 'git@[^"]*' | xargs -L1 git clone
}

gi() {
	curl -sL https://www.toptal.com/developers/gitignore/api/"$*" ;
}

# gh aliases
if which gh >/dev/null 2>&1; then
	alias ghr='gh repo'
	alias ghrc='gh repo create'
	alias ghs='gh status'
	alias ghpr='gh pr'
fi

alias dfh='df -h' #disk space

# if dust is installed alias du to it
if which dust >/dev/null 2>&1; then
	alias du='dust'
else
	# actually readable du
	alias du='du -sh'
	alias dush='du -sh'
fi

# docker and docker-compose aliases
alias docker='sudo docker'
alias dps='sudo docker ps'
alias dockerkillall='sudo docker kill $(docker container ls -q)'
alias docker-compose='sudo docker-compose'
alias dcud='sudo docker-compose up -d'
alias dcd='sudo docker-compuse down'
alias dcp='sudo docker-compose pull'

# pull and restart
pdu() {
	dcp
	dcd
	dcud
}
# just restart
downup() {
	dcd
	dcud	
}


# file management / navigation aliases

alias fld='sudo du -ahx . | sort -rh | head -5' #finds large dirs
alias untar='tar -zxvf' #extract files from archive
alias back='cd -' #go back to the directory you were in previously (should probably add some pushd stuff here)
# -v adds verbosity, -i makes it interactive 
alias mkdir='mkdir -pv' #make a directory allowing for layering e.g. mkdir foo/bar/  
alias rm='rm -vi' #remove file
alias rmr='rm -rv' #remove recursively 
alias rmdir='rmdir -v' #remove directory
alias cp='cp -vi'  #copy 
alias cpdir='cp -vr' #copy directory and contents
alias mv='mv -vi' #move
alias words='wc -w' #check word count of a file   
alias aria='aria2c --console-log-level=error'
alias gzipc='gzip --keep -9' #max compression keeping the file

# file management / navigation functions

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
# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
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

# misc aliases and functions, yet to group
alias ipe='curl ipinfo.io/ip' #check external ip address
alias c='clear' #clear terminal
alias yt='yt-dlp' #download a YT video
alias mp3='yt-dlp -x --audio-format mp3' #grab the mp3 of a YT video
alias eb='clear && exec bash' #reload bash and clear the terminal screen
alias upstats='echo "Up since:" && uptime -s && uptime -p' #displays uptime stats 
alias reboot='sudo reboot'
#https://github.com/gleitz/howdoi
hdi(){ howdoi "$*" -c; }
alias pyvenv='virtualenv env -p python3 && source env/bin/activate' # start a python virtual environment

# top for containers
ctop(){
  docker run --rm -ti \
  --name=ctop \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  quay.io/vektorlab/ctop:latest
}

listen-to-yt() { 
	if [[ -z "$1" ]]; then 
	echo "Enter a search string!"; 
	else mpv "$(youtube-dl --default-search "ytsearch1:" \""$1"\" --get-url | tail -1)";
	fi
}
