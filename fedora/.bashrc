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

if [ -f $HOME/.bashrc.d/.bash_aliases ] ; then
	source $HOME/.bashrc.d/.bash_aliases
fi

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
if which sccache >/dev/null 2>&1; then
	export RUSTC_WRAPPER=sccache;
fi