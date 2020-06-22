export PS1="\w @ \h (\u)|\t\n____________________ => "

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Setting PATH for Python 3.6 The original version is saved in .bash_profile.pysave
new_path="/usr/local/opt/ruby/bin:/usr/local/:/Library/Frameworks/Python.framework/Versions/3.6/bin:~/.scripts"

case ":$PATH:" in
  *":$new_path:"*) :;; # already there
  *) PATH="$new_path:$PATH";; # or PATH="$PATH:$new_entry"
esac
export PATH

alias back='. back'

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

#watch the user's Downloads folder and send any word documents with a matching name to a specific folder
#fswatch -0 -e ".*" -Ii "*kana*.docx$" --event OwnerModified  ~/Downloads/ | xargs -0 -n 1 -I {}  mv {} ~/Documents/Misc/Japanese/worksheets &
#automatically move all incoming pictures
#fswatch -0 -e ".*" -EIi "\\.(jpg|png|bmp|jpeg)$" --event OwnerModified . | xargs -0 -n 1 -I {} [ wc -c {} -ge 10000 ] && mv {} ~/Pictures/Downloads &

#Adding autocomplete to bash command
source ~/.scripts/back-completion.bash
