export PS1="\w @ \h (\u)|\t\n____________________ => "

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Setting PATH for Python 3.6 The original version is saved in .bash_profile.pysave
new_path="/Library/Frameworks/Python.framework/Versions/3.6/bin:~/.scripts"

case ":$PATH:" in
  *":$new_path:"*) :;; # already there
  *) PATH="$new_path:$PATH";; # or PATH="$PATH:$new_entry"
esac
export PATH

#function to check if a newly navigated directory is a git directory
gd() {
cd "$1" || return
for i in $(ls -a)
do
	if [ $i  == ".git" ]
	then
		echo "Eureka!"
		git fetch
		git status
		return
	fi
done
}

#function to unpack all files in a child directory of the cwd to the cwd and then remove the directory
collapse(){
	rm -r $1
	rmdir $1
}

dockexec(){
	docker exec -it DOCK sh -c $1
}

set_container(){
	export DOCK=$1
}

#function to sequentially traverse back up the file system until a directory keyword is matched and return the absolute path to this location
back() {
	return=$(echo $(pwd) | gsed -ne "s/\/$1\/.*$/\/$1/I p")
	if [ $return ]
	then
		cd $return && echo $pwd
	else
		echo "Didn't find directory name '$1' in current path"
	fi
}

#NOTE: this is currentl only for a specific use case and needs to be adapted for other cases
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

if [ -f ~/.bashrc ]; then
source ~/.bashrc
fi
