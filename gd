#/usr/bin/env bash

if [ -z $1 ]; then echo "gd: no directory arg"; return; fi
cd "$1" || return 
if [ -d ".git" ]
then 
	git status 
fi 
