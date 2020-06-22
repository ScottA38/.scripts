#/usr/bin/env bash

cd "$1" || return 
for i in $(ls -a) 
do 
	if [ $i == ".git" ] then 
		echo "Eureka!" 
		git status 
		return;
	fi 
done
