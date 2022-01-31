#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

#sets the prompt to the userame@hostname with the full working directory, starts a newline for the command to be on
PS1="\e[35m\u@\h~$ \n\w > \e[m"

########
#ALCI
########
alias evb='sudo systemctl enable --now vboxservice.service'
#######

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
## better-ls
if [ -f /home/ctome/.config/synth-shell/better-ls.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/ctome/.config/synth-shell/better-ls.sh
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



#user aliases
#some apapted/taken from sbrl's bash aliases
alias pi='sudo pacman -S'
alias pu='sudo pacman -Syu'
alias gc='git clone'
alias gpl='git pull'
alias gph='git push'
alias gl='git log'
alias gac='git commit -am'
alias gs='git status'
alias his='history > history.log && cat history.log'
alias untar='tar -zxvf'
alias ipe='curl ipinfo.io/ip'
alias c='clear'
alias lines='wc -l'
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
# end of manual aliases
