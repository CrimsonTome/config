# Fish abbreviations converted from bash aliases

abbr q exit
# Basic abbreviations
abbr c clear

# Define a function to set abbreviations based on command availability
function set_abbr
    # Check if the command is usable
    if command -v $argv[1] > /dev/null
        # Loop through the remaining arguments
        for abbr_def in $argv[2..-1]
            # Split arguments into parts and set abbreviation
            set -l abbr_parts (string split ' ' $abbr_def)
            abbr $abbr_parts[1] $abbr_parts[2..-1]
        end
    end
end

# Set abbreviations for lsd
set_abbr lsd \
    'ls lsd -lth' \
    'lsa lsd -lAth'

# Set abbreviations for dnf
set_abbr dnf \
    'di sudo dnf install' \
    'dug sudo dnf upgrade --refresh -y' \
    'ds dnf search' \
    'dr sudo dnf remove' \
    'dli dnf list installed' \
    'dlu dnf history userinstalled'

# Set abbreviations for apt
set_abbr apt \
    'ai sudo apt install' \
    'aud sudo apt update && sudo apt upgrade -y' \
    'as apt search' \
    'ar sudo apt remove' \
    'aar sudo apt autoremove'

# Override apt abbreviations if nala is installed
set_abbr nala \
    'ai sudo nala install' \
    'aud sudo nala upgrade -y' \
    'as nala search' \
    'ar sudo nala remove' \
    'aar sudo nala autoremove'

# git abbreviations
set_abbr git \
    'gc git clone' \
    'gpl git pull' \
    'gph git push' \
    'gl git log' \
    'gs git status' \
    'gr git remote -v' \
    'gca git commit --amend' \
    'gb git branch' \
    'gco git checkout' \
    'gd git diff' \
    'gf git fetch' \
    'gm git merge' \
    'grb git rebase' \
    'grs git reset' \
    'gst git stash' \
    'gt git tag'
# TODO: rewrite git pull all in fish


# gh abbreviations
set_abbr gh \
    'ghr gh repo' \
    'ghrc gh repo create' \
    'ghrcl gh repo clone' \
    'ghrf gh repo fork' \
    'ghrv gh repo view' \
    'ghi gh issue' \
    'ghic gh issue create' \
    'ghil gh issue list' \
    'ghpr gh pr' \
    'ghprc gh pr create' \
    'ghprl gh pr list' \
    'ghprm gh pr merge'

# rm abbreviations
set_abbr rm \
    'rm rm -iv' \
    'rmr rm -rv' \
    'rmrf rm -rfv'

# System monitoring abbreviations
set_abbr btop 'top btop' \
        'htop btop'
abbr mem 'free -mh'
abbr cpu 'lscpu'
abbr disk 'df -h'


# disk  space
abbr dfh 'df -h'

# Docker abbreviations
# Set abbreviations for Docker
set_abbr docker \
    'dps docker ps' \
    'di docker images' \
    'dr docker run' \
    'dex docker exec -it' \
    'dst docker stop' \
    'drm docker rm' \
    'drmi docker rmi'

# finds large dirs based on your current working directory
abbr fld 'sudo du -ahx . | sort -rh |head -5'

abbr back 'cd -'

abbr cp 'cp -iv'
abbr mv 'mv -iv'
abbr words 'wc -w'
abbr lines 'wc -l'

# grab external ip address
abbr ipe 'curl ipinfo.io/ip'
abbr reboot 'sudo reboot now'
