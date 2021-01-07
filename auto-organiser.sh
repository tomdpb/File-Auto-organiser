#!/bin/bash
#if [[ -f * ]] || echo "There's a snake in my boot!"

dir_2_search=~/Downloads

check_for_items(){
	if [ -z "$(ls -A ${dir_2_search})" ]; then
		echo "Target directory $dir_2_search is empty."
		echo "Exiting..."
		exit
	else
		echo "Something's in the target directory $dir_2_search!"
	fi
}

classifier(){
	file $1
}

check_for_items
counter=0

shopt -s nullglob
for entry in $(find "${dir_2_search}" -maxdepth 0); do
	echo $entry > this.txt
	echo >> this.txt	
	classifier $entry >> this.txt
	counter+=1
done

echo $counter
