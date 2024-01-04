# Fish abbreviations converted from bash aliases

abbr q exit
abbr c clear

# if the system has lsd installed
if command -v lsd > /dev/null
    abbr ls 'lsd -lth'
    abbr lsa 'lsd -lAth`'
end

# if the system uses the dnf package manager
if command -v dnf > /dev/null
    abbr di 'sudo dnf install'
    abbr dug 'sudo dnf upgrade --refresh -y'
    abbr ds 'dnf search'
    abbr dr 'sudo dnf remove'
    abbr dli 'dnf list installed'
    abbr dlu 'dnf history userinstalled'
end

# if the system uses the apt package manager
if command -v apt > /dev/null
    abbr ai 'sudo apt install'
    abbr aud 'sudo apt update && sudo apt upgrade -y'
    abbr as 'apt search'
    abbr ar 'sudo apt remove'
    abbr aar 'sudo apt autoremove'
    # if nala is installed
    if command -v nala > /dev/null
        abbr ai 'sudo nala install'
        abbr aud 'sudo nala upgrade -y'
        abbr as 'nala search'
        abbr ar 'sudo nala remove'
        abbr aar 'sudo nala autoremove'
    end
end

# git abbreviations
abbr gc 'git clone'
abbr gpl 'git pull'
abbr gph 'git push'
abbr gl 'git log'
abbr gs 'git status'
abbr gr 'git remote -v'
abbr gitamendcomment 'git commit --amend'
# TODO: rewrite git pull all in fish


# gh abbreviations

if command -v gh > /dev/null
    abbr ghr 'gh repo'
    abbr ghrc 'gh repo create'
    abbr ghs 'gh status'
    abbr ghpr 'gh pr'
end

# dish space
abbr dfh 'df -h'

# docker abbreviations
abbr dps 'docker ps'

# file management and navigation abbreviations

# finds large dirs based on your current working directory
abbr fld 'sudo du -ahx . | sort -rh |head -5'
alias back 'cd -'
abbr mkdir 'mkdir -pv'
abbr rm 'rm -iv'
abbr rmr 'rm -rv'
abbr cp 'cp -iv'
abbr mv 'mv -iv'
abbr words 'wc -w'
abbr lines 'wc -l'

# misc abbreviations that have not been grouped
# grab externel ip address
abbr ipe 'curl ipinfo.io/ip'
abbr reboot 'sudo reboot now'
