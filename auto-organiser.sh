#!/bin/bash
#if [[ -f * ]] || echo "There's a snake in my boot!"

dir_to_search=~/Downloads

log_location=~/Documents/file_organiser_log.txt

audio_directory=~/Music
documents_directory=~/Documents
images_directory=~/Pictures
video_directory=~/Videos
unrecognised_directory=${dir_to_search}"/unrecognised"

#alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


check_for_items(){
	if [ -z "$(ls -A ${dir_to_search})" ]; then 
		#-a isn't used to not trigger '.' and '..'
		echo "Target directory $dir_to_search is empty."
		echo "Exiting..."
		exit
	else
		echo "Something's in the target directory $dir_to_search!"
	fi
}


check_for_items


move_to_dir(){
	echo "Yes?"
	case $1 in
		*.flac)
			echo "$1 is a flac file and will be moved to $audio_directory."
			break ;;
		*.mp3)
			echo "$1 is an mp3 file and will be moved to $audio_directory."
			break ;;
		*.m4a)
			echo "$1 is an m4a file and will be moved to $audio_directory."
			break ;;
		*.ogg)
			echo "$1 is an ogg file and will be moved to $audio_directory."
			break ;;
		*.wav)
			echo "$1 is a wav file and will be moved to $audio_directory."
			break ;;
		#############################################################################
		*.doc)
			echo "$1 is a doc file and will be moved to $documents_directory."
			break ;;
		*.docx)
			echo "$1 is a docx file and will be moved to $documents_directory."
			break ;;
		*.key)
			echo "$1 is a keynote file and will be moved to $documents_directory."
			break ;;
		*.pages)
			echo "$1 is a pages file and will be moved to $documents_directory."
			break ;;
		*.PDF)
			echo "$1 is a PDF file and will be moved to $documents_directory."
			break ;;
		*.pdf)
			echo "$1 is a pdf file and will be moved to $documents_directory."
			break ;;
		*.ppt)
			echo "$1 is a ppt file and will be moved to $documents_directory."
			break ;;
		*pptx)		
			echo "$1 is a pptx file and will be moved to $documents_directory."
			break ;;
		*.rtf)
			echo "$1 is a rtf file and will be moved to $documents_directory."
			break ;;
		*.txt)
			echo "$1 is a txt file and will be moved to $documents_directory."
			break ;;
		#############################################################################	
		*.jpg)
			echo "$1 is a jpg file and will be moved to $images_directory."
			break ;;
		*.jpeg)
			echo "$1 is a jpeg file and will be moved to $images_directory."
			break ;;
		*.png)
			echo "$1 is a png file and will be moved to $images_directory."
			break ;;
		*.webp)
			echo "$1 is a webp file and will be moved to $images_directory."
			break ;;
		#############################################################################
		*.avi)
			echo "$1 is an avi file and will be moved to $video_directory."
			break ;;
		*.mkv)
			echo "$1 is an mkv file and will be moved to $video_directory."
			break ;;
		*.mp4)
			echo "$1 is an mp4 file and will be moved to $video_directory."
			break ;;
		#############################################################################
		*)
			echo "$1 was not recognised and will be placed in $unrecognised_directory."
			#mv $1 $unrecognised_directory || mkdir $unrecognised_directory && mv $item $unrecognised_directory
			break ;;
	esac
}
echo "Just before loop"
while IFS= read -r -d '' file; do
	echo "Loop time"
	move_2_dir "$file"
done < <(find . -type f -name '*.mp3' -print0)
#find $dir_to_search -maxdepth 1 -path $unrecognised_directory -prune -type f -exec move_2_dir {} \;
