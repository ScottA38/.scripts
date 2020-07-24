PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{yellow}%~%f%b %# '

HISTFILE=$HOME/.zsh_history

#adding a directory for search to the function definition files path
fpath+=~/.scripts

#For when you forget to cd
setopt AUTO_CD

#deactivate case-sensitive globbing default
unsetopt CASE_GLOB

#Formats history entries more nicely
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
#verify history-substituted command before running
setopt HIST_VERIFY

#allows the user to cycle through autocomplete options by continuing to press the autocomplete button
setopt MENU_COMPLETE

alias back='. back'

autoload -U compinit
compinit

# Adding parts of path manually
# Setting PATH for Python 3.6 The original version is saved in .bash_profile.pysave
PATH="$PATH:/usr/local/opt/ruby/bin:/usr/local/:/Library/Frameworks/Python.framework/Versions/3.6/bin:~/.scripts"

case ":$PATH:" in
  *":$new_path:"*) :;; # already there
  *) PATH="$new_path:$PATH";; # or PATH="$PATH:$new_entry"
esac

#function to unpack all files in a child directory of the cwd to the cwd and then remove the directory
collapse(){
	mv $1/* $1/../
	rmdir $1
}

dockec(){
	docker exec -it "$DOCK" sh -c "$1"
}

dockont(){
	results=$(docker ps | grep $1 | awk '{ print $1 }' |  head -n 1)
	[ ! -z "$results" ] && export DOCK=$results
}

#NOTE: this is currently only for a specific use case and needs to be adapted for other cases
batch_rename() {
	set -u
	interval=$1
	prefix=$2

	for f in $prefix*.*
	do
		n="${f/SCAN}"
		n="${n%.*}"
		n=$((10#$n))
		((n+=$interval))
		mv "$f" "SCAN$n.jpg"
	done
}
