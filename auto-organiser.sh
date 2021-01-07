#!/bin/bash
#if [[ -f * ]] || echo "There's a snake in my boot!"

dir_2_search=~/Downloads

log_directory=~/Documents/file_organiser_log.txt

audio_directory=~/Music
documents_directory=~/Documents
images_directory=~/Pictures
video_directory=~/Videos
unrecognised_directory=$($dir_2_search"/unrecognised")

function check_for_items{
	if [ -z "$(ls -A ${dir_2_search})" ]; then 
		#-a isn't used to not trigger '.' and '..'
		echo "Target directory $dir_2_search is empty."
		echo "Exiting..."
		exit
	else
		echo "Something's in the target directory $dir_2_search!"
	fi
}



check_for_items
counter=0 #for testing only

#shopt -s nullglob

function move_to_dir{
	case $item in
		*.flac)
			echo "$item is a flac file and will be moved to $audio_directory."
			break ;;
		*.mp3)
			echo "$item is an mp3 file and will be moved to $audio_directory."
			break ;;
		*.m4a)
			echo "$item is an m4a file and will be moved to $audio_directory."
			break ;;
		*.ogg)
			echo "$item is an ogg file and will be moved to $audio_directory."
			break ;;
		*.wav)
			echo "$item is a wav file and will be moved to $audio_directory."
			break ;;
		#############################################################################
		*.doc)
			echo "$item is a doc file and will be moved to $documents_directory."
			break ;;
		*.docx)
			echo "$item is a docx file and will be moved to $documents_directory."
			break ;;
		*.key)
			echo "$item is a keynote file and will be moved to $documents_directory."
			break ;;
		*.pages)
			echo "$item is a pages file and will be moved to $documents_directory."
			break ;;
		*.PDF)
			echo "$item is a PDF file and will be moved to $documents_directory."
			break ;;
		*.pdf)
			echo "$item is a pdf file and will be moved to $documents_directory."
			break ;;
		*.ppt)
			echo "$item is a ppt file and will be moved to $documents_directory."
			break ;;
		*pptx)		
			echo "$item is a pptx file and will be moved to $documents_directory."
			break ;;
		*.rtf)
			echo "$item is a rtf file and will be moved to $documents_directory."
			break ;;
		*.txt)
			echo "$item is a txt file and will be moved to $documents_directory."
			break ;;
		#############################################################################	
		*.jpg)
			echo "$item is a jpg file and will be moved to $images_directory."
			break ;;
		*.jpeg)
			echo "$item is a jpeg file and will be moved to $images_directory."
			break ;;
		*.png)
			echo "$item is a png file and will be moved to $images_directory."
			break ;;
		*.webp)
			echo "$item is a webp file and will be moved to $images_directory."
			break ;;
		#############################################################################
		*.avi)
			echo "$item is an avi file and will be moved to $video_directory."
			break ;;
		*.mkv)
			echo "$item is an mkv file and will be moved to $video_directory."
			break ;;
		*.mp4)
			echo "$item is an mp4 file and will be moved to $video_directory."
			break ;;
		#############################################################################
		*)
			echo "$item was not recognised and will be placed in $dir_2_search/unrecognised."
			mv $item $unrecognised_directory) || mkdir $unrecognised_directory && mv $item $unrecognised_directory
			break ;;
	esac

for entry in $(find "${dir_2_search}" -maxdepth 0); do
	echo $entry > this.txt #CHANGE TO >> BEFORE RELEASING
	echo >> this.txt	
	classifier $entry >> this.txt
	counter+=1
done

echo $counter #for testing only
