#!/bin/bash

display_help () {
	echo "This is a program which will automatically organise files from one directory to another."
	echo "Any files in subdirectories will remain where they are." 
	echo "Options are:"
	echo "-d	Displays searching directory and exits."
	echo "-h	Displays this help text and exits."
}


dir_to_search="$HOME/Downloads"
#this is the directory where the script will be applied

while getopts "dh" option; do
        case $option in
		d)
			echo "$dir_to_search"
			exit;;
		h)
                        display_help
                        exit;;
                \?)
                         echo "Error: invalid option."
			 display_help
                         echo "Exiting..."
                         exit;;
         esac
done



check_for_items () {
	#checks to see if there are any files in the specified directory
	#exits if there are none
	if [ -z "$(find "$dir_to_search" -maxdepth 1 -type f)" ]; then
		exit
	fi
}


check_for_items


###############################################################################
#If no files are found, there's no point in running the rest of this code.
#The function checks and makes sure none of this runs for no reason.
###############################################################################

log_file="$HOME/Documents/file_organiser_log.log"
#where the log of changes is placed
touch "$log_file"

current_date=`date +"%Y-%m-%d %T"`
echo "Program called at $current_date" >> $log_file

#the following variables determine where to place found items
audio_directory="$HOME/Music"
compressed_directory="$dir_to_search/Compressed Files"
documents_directory="$HOME/Documents"
images_directory="$HOME/Pictures"
video_directory="$HOME/Videos"
unsorted_directory="$dir_to_search/Unsorted"



file_name_only () {
	#removes the path of a file/variable so just its name is printed
	prefix="$dir_to_search/"
	foo="${1#"$prefix"}"
	echo "${foo}"
}


information_of_file_only () {
	#removes the name of the file so it doesn't interfere when calling 'file' command
	#if a video file is called audio_file it ccould be falsely classified as audio
	prefix="$1"
	information=$(file "$1")
	foo="${information#"$prefix"}"
	echo "${foo}"
}


move_to_dir () {
	#attempts to move files to directories. If that fails, creates the directory and then moves the file
	mkdir -p "$2"
	mv "$1" "$2"
}


sorting_files () {
	#reads a file, extracts information with the 'file' command, classifies it, and moves it accordingly.
	#if one wishes to add another file type, only add the unique part of the returned text and make sure to have asterisks around it 
	#if in doubt, check the examples given
	item="$(file_name_only "$1")"
	item_type=$(information_of_file_only "$1")
	case $item_type in
		*FLAC* | *flac*)
			echo "'$item' was identified as a flac file and was moved to $audio_directory." >> $log_file
			move_to_dir "$1" "$audio_directory"
			;;
		*Ogg* | *ogg*)
			echo "'$item' was identified as an ogg file and was moved to $audio_directory." >> $log_file
			move_to_dir "$1" "$audio_directory"
			;;
		*Vorbis* | *vorbis*)
			echo "'$item' was identified as a vorbis audio file and was moved to $audio_directory." >> $log_file
			move_to_dir "$1" "$audio_directory"
			;;
		*WAVE* | *wave* | *wav*)
			echo "'$item' was identified as a wav audio file and was moved to $audio_directory." >> $log_file
			move_to_dir "$1" "$audio_directory"
			;;
		*Audio* | *audio*)
			echo "'$item' fell under the catch-all 'audio' category and was moved to $audio_directory." >> $log_file
            move_to_dir "$1" "$audio_directory"
            ;;
		#############################################################################
		*ASCII*)
			echo "'$item' was identified as a plain text file and was moved to $documents_directory." >> $log_file
			move_to_dir "$1" "$documents_directory"
			;;
		*Composite\ Document*)
			echo "'$item' was identified as either a doc, ppt or xls file and was moved to $documents_directory" >> $log_file
			move_to_dir "$1" "$documents_directory"
			;;
		*Microsoft\ Excel*)
			echo "'$item' was identified as an Excel file and was moved to $documents_directory." >> $log_file
			move_to_dir "$1" "$documents_directory"
			;;
		*Microsoft\ PowerPoint*)
			echo "'$item' was identified as a PowerPoint file and was moved to $documents_directory." >> $log_file
			move_to_dir "$1" "$documents_directory"
			;;
		*Microsoft\ Word*)
			echo "'$item' was identified as a Word document file and was moved to $documents_directory." >> $log_file
			move_to_dir "$1" "$documents_directory"
			;;
		*OpenDocument*)
			echo "'$item' was identified as an Open Document file and was moved to $documents_directory." >> $log_file
			move_to_dir "$1" "$documents_directory"
			;;
		*PDF* | *pdf*)
			echo "'$item' was identified as a pdf file and was moved to $documents_directory." >> $log_file
			move_to_dir "$1" "$documents_directory"
			;;
		*Rich\ Text*)
			echo "'$item' was identified as a rich text file and was moved to $documents_directory" >> $log_file
			move_to_dir "$1" "$documents_directory"
			;;
		*Unicode\ text*)
			echo "'$item' was identified as a plain text file and was moved to $documents_directory." >> $log_file
			move_to_dir "$1" "$documents_directory"
			;;
		*document* | *Document*)
			echo "'$item' fell under the catch-all 'documents' category and was moved to $documents_directory." >> $log_file
			move_to_dir "$1" "$documents_directory"
			;;
		#############################################################################
		*bitmap*)
			echo "'$item' was identified as a bmp file and was moved to $images_directory." >> $log_file
			move_to_dir "$1" "$images_directory"
			;;
		*GIF* | *gif*)
			echo "'$item' was identified as a gif file and was moved to $images_directory." >> $log_file
			move_to_dir "$1" "$images_directory"
			;;
		*JPEG* | *jpeg*)
			echo "'$item' was identified as a jpg or a jpeg file and was moved to $images_directory." >> $log_file
			move_to_dir "$1" "$images_directory"
			;;
		*PNG*)
			echo "'$item' was identified as a png file and was moved to $images_directory." >> $log_file
			move_to_dir "$1" "$images_directory"
			;;
		*image* | *Image*)
			echo "'$item' fell under the catch-all 'images' category and was moved to $images_directory." >> $log_file
			move_to_dir "$1" "$images_directory"
			;;
		#############################################################################
		*AVI* | *avi*)
			echo "'$item' was identified as an avi file and was moved to $video_directory." >> $log_file
			move_to_dir "$1" "$video_directory"
			;;
		*Matroska* | *matroska*)
			echo "'$item' was identified as a mkv file and was moved to $video_directory." >> $log_file
			move_to_dir "$1" "$video_directory"
			;;
		*MP4* | *mp4*)
			echo "'$item' was identified as an mp4 file and was moved to $video_directory." >> $log_file
			move_to_dir "$1" "$video_directory"
			;;
		*MPEG* | *mpeg*)
			echo "'$item' was identified as an mpeg file and was moved to $video_directory." >> $log_file
			move_to_dir "$1" "$video_directory"
			;;
		*QuickTime*)
			echo "'$item' was identified as a QuickTime file and was moved to $video_directory." >> $log_file
			move_to_dir "$1" "$video_directory"
			;;
		*WebM* | *webm*)
			echo "'$item' was identified as a webm file and was moved to $video_directory." >> $log_file
			move_to_dir "$1" "$video_directory"
			;;
		*movie*)
			echo "'$item' fell under the all-catch 'movie' category and was moved to $video_directory." >> $log_file
			move_to_dir "$1" "$video_directory"
			;;
		*video* | *VIDEO*)
			echo "'$item' fell under the catch-all 'video' category and was moved to $video_directory." >> $log_file
			move_to_dir "$1" "$video_directory"
			;;
		#############################################################################
		*XZ* | *xz*)
			echo "'$item' was identified as a compressed file. It will not be unpacked and was moved to $compressed_directory." >> $log_file
			move_to_dir "$1" "$compressed_directory"
			;;
		*Zip* | *zip*)
			echo "'$item' was identified as a zipped file. It will not be unpacked and was moved to $compressed_directory." >> $log_file
			move_to_dir "$1" "$compressed_directory"
			;;
		#############################################################################
		*)
			echo "'$item' was not recognised and was placed in $unsorted_directory." >> $log_file
			move_to_dir "$1" "$unsorted_directory"
			;;
	esac
}

temp_file="/tmp/auto_organiser_temp.txt"

find "$dir_to_search" -maxdepth 1 -type f -exec echo {} > "$temp_file" \;

while IFS= read -r line
do
	sorting_files "$line"
done < "$temp_file"

rm "$temp_file"
