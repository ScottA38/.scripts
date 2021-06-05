#Set prompt library
#PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{yellow}%~%f%b %# '
source $ZDOTDIR/submodules/agkozak-zsh-prompt/agkozak-zsh-prompt.plugin.zsh

# Set prompt config
AGKOZAK_MULTILINE=0
AGKOZAK_LEFT_PROMPT_ONLY=1

HISTFILE=$HOME/.zsh_history

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

#setting aliases
alias cl='clear'
alias back='. back'
alias dockerd='open -a docker'
alias gs="git status"

autoload -U compinit
compinit

#Setting colourised ls output
export CLICOLOR=1
zstyle ':completion:*' list-colors 'di=1;36:ln=1;35:so=1;31:pi=1;33:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# Adding parts of path manually
# Setting PATH for Python 3.6 The original version is saved in .bash_profile.pysave
PATH="/usr/local/opt/ruby/bin:/usr/local/:~/.scripts:$HOME/.rvm/bin:$PATH"

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

#adding a directory for search to the function definition files path
PATH=$ZDOTDIR:$PATH

# Add init line for rvm
. ~/.rvm/scripts/rvm 
