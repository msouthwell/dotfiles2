#!/bin/bash

PATH="/usr/local/bin:$(getconf PATH)"
 #Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
for file in ~/.dotfiles/{path,exports}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

unset file;
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
