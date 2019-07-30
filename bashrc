#!/bin/bash

 #Load the shell dotfiles, and then some:
for file in ~/.dotfiles/{bash_prompt,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

assignProxy(){
    PROXY_ENV="http_proxy ftp_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY"
    for envar in $PROXY_ENV
    do
        export $envar=$1
    done
    for envar in "no_proxy NO_PROXY"
    do
        export $envar=$2
    done
    
    echo "Proxy set to $1"
}

proxydown(){
    assignProxy "" # Unsets the proxy
}

proxyup(){
    user=""
    proxy_value=""
    not_proxied_value="localhost,127.0.0.01,LocalAddress,LocalDomain.com,"$(printf '%s,' 192.168.0.{0..255})
    assignProxy $proxy_value $not_proxied_value
}

#proxyup
#proxydown

export EDITOR=nvim
export VISUAL=nvim

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;
#
## Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;
#
## Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
#
## Add tab completion for `defaults read|write NSGlobalDomain`
## You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

