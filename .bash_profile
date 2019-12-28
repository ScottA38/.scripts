alias ls='ls -GF'
alias te='open -e'

export PS1="\w @ \h (\u)|\t\n____________________ => "

export CLICOLOR=1

export LSCOLORS=ExFxBxDxCxegedabagacad

alias xampp="echo ~/.bitnami/stackman/machines/xampp/volumes/root"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
#add custom bash/scripting lang scripts
PATH="~/.scripts:${PATH}"
export PATH

#create a new github repository via curl
#nurep() {
#	curl -u 'ScottA38' https://api.github.com/user/repos -d '{"name": "'"${1}"'"}'
#	echo "Name is: $1"
#}

#function for fs traversal where you want to automatically
#know if the directory is a git directory without looking
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
	mv $1/* .
	rmdir $1
}

#function to sequentially traverse back up the file system until a directory keyword is matched and return the absolute path to this location
back() {
	return=$(echo $(pwd) | gsed -ne "s/\/$1\/.*$/\/$1/I p")
	if [ $return ]
	then
		cd $return
		echo "New path is $(pwd)"
	else
		echo "Didn't find directory name '$1' in current path"
	fi
}

#NOTE: this is currentl only for a specific use case and needs to be adapted for other cases
batch_rename() {
	set -u
	target_dir=$1
	interval=$2
	prefix=$3

	pushd $target_dir

	for f in $prefix*.*
	do
		n="${f/SCAN}"
		n="${n%.*}"
		n=$((10#$n))
		((n+=$interval))
		mv "$f" "SCAN$n.jpg"
	done

	popd
}
