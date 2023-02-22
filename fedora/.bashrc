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
shopt -s histappend


# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc



alias vim='hx'
alias q='exit'
alias ls='lsd -lrthA'
alias di='sudo dnf install'
alias dud='sudo dnf update -y'
alias ds='dnf search'
alias dr='sudo dnf remove'
alias dar='sudo dnf autoremove'
alias dli='dnf list --installed'
alias gc='git clone' #clone a git repo
alias gpl='git pull' #pull updates from a git repo
alias gph='git push' #push local updates to a git repo
alias gl='git log' #check git log
alias gcm='commit'
alias gs='git status' #check git status
alias gr='git remote -v'
alias ghr='gh repo'
alias ghrc='gh repo create'
alias ghs='gh status'
alias ghpr='gh pr'
alias dfh='df -h' #disk space
alias dush='du -sh'
alias docker='sudo docker'
alias docker-compose='sudo docker-compose'
alias dcud='sudo docker-compose up -d'
alias dcd='sudo docker-compuse down'
alias dcp='sudo docker-compose pull'

pdu() {
	dcp
	dcd
	dcud
}

downup() {
	dcd
	dcud	
}

alias dockerkillall='sudo docker kill $(docker container ls -q)'
alias univpn='cd ~/; ./hullvpn; cd -'
alias fld='sudo du -ahx . | sort -rh | head -5' #finds large dirs
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
alias pullall='for i in */.git; do cd $(dirname $i); git pull -q; cd ..; done; echo done'
alias aria='aria2c --console-log-level=error'
alias gzipc='gzip --keep -9' #max compression keeping the file
alias gitamendcomment='git commit --amend'
alias reboot='sudo reboot'

#https://github.com/gleitz/howdoi
alias h='function hdi(){ howdoi $* -c; }; hdi'

alias pyvenv='virtualenv env -p python3 && source env/bin/activate'

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
ctop(){

  docker run --rm -ti \
  --name=ctop \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  quay.io/vektorlab/ctop:latest
}
listen-to-yt() { if [[ -z "$1" ]]; then echo "Enter a search string!"; else mpv "$(youtube-dl --default-search 'ytsearch1:' \"$1\" --get-url | tail -1)"; fi }

eval "$(starship init bash)"
export GPG_TTY=/dev/pts/2
function gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}
export DOTNET_ROOT=$HOME/.dotnet
export EDITOR="hx"
export PAGER="less"
complete -C /usr/bin/terraform terraform

# Created by `pipx` on 2022-11-14 15:41:06
export PATH="$PATH:/home/ctome/.local/bin"

# >>> talisman >>>
# Below environment variables should not be modified unless you know what you are doing
export TALISMAN_HOME=/home/ctome/.talisman/bin
alias talisman=$TALISMAN_HOME/talisman_linux_amd64
export TALISMAN_INTERACTIVE=true
# <<< talisman <<<
. "$HOME/.cargo/env"
eval "$(mcfly init bash)"
export MCFLY_LIGHT=FALSE
export MCFLY_KEY_SCHEME=vim