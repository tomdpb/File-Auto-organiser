#!/bin/bash

check_for_items(){
	if [ -z "$(ls -A "$dir_to_search")" ]; then
		#-a isn't used to not trigger '.' and '..'
		echo "Target directory $dir_to_search is empty."
		echo "Exiting..."
		exit
	else
		echo "Something's in the target directory $dir_to_search!"
	fi
}


check_for_items


dir_to_search="$HOME/Downloads/Test/Designed to fail"

log_location="$HOME/Documents/file_organiser_log.txt"

audio_directory="$HOME/Music"
documents_directory="$HOME/Documents"
images_directory="$HOME/Pictures"
video_directory="$HOME/Videos"
unsorted_directory=${dir_to_search}"/Unsorted"


file_name_only (){

}

move_to_dir () {
	echo
    	item="$1"
	item_type=$(file "$1")
	case $item_type in
		*FLAC* | *flac*)
			echo "$item was identified as a flac file and will be moved to $audio_directory."
			;;
		*Ogg* | *ogg*)
			echo "$item was identified as an ogg file and will be moved to $audio_directory."
			;;
		*Vorbis* | *vorbis*)
			echo "$item was identified as a vorbis audio file and will be moved to $audio_directory."
			;;
		*WAVE* | *wave* | *wav*)
			echo "$item was identified as a wav audio file and will be moved to $audio_directory."
			;;
		*Audio* | *audio*)
			echo "$item fell under the catch-all 'audio' category and will be moved to $audio_directory. This is probably not an incorrect recognition, but verifying would be recommended."
                        ;;
 
		#############################################################################
		*ASCII*)
			echo "$item was identified as a plain text file and will be moved to $documents_directory."
			;;
		*Composite\ Document*)
			echo "$item was identified as a possibly a doc, ppt or xls file and will be moved to $documents_directory"
			;;
		*Microsoft\ Excel*)
			echo "$item was identified as Excel file and will be moved to $documents_directory."
			;;
		*Microsoft\ PowerPoint*)
			echo "$item was identified as a PowerPoint file and will be moved to $documents_directory."
			;;
		*Microsoft\ Word*)
			echo "$item was identified as a Word document file and will be moved to $documents_directory."
			;;
		*OpenDocument*)
			echo "$item was identified as an Open Document file and will be moved to $documents_directory."
			;;
		*PDF* | *pdf*)
			echo "$item was identified as a pdf file and will be moved to $documents_directory."
			;;
		*Rich\ Text*)
			echo "$item was identified as a rich text file and will be moved to $documents_directory"
			;;
		*Unicode\ text*)
			echo "$item was identified as a plain text file and will be moved to $documents_directory."
			;;
		*document* | *Document*)
			echo "$item fell under the catch-all 'documents' category and will be moved to $documents_directory. This is probably not an incorrect recognition, but verifying would be recommended."
			;;
		#############################################################################
		*bitmap*)
			echo "$item was identified as a bmp file and will be moved to $images_directory."
			;;
		*GIF* | *gif*)
			echo "$item was identified as a gif file and will be moved to $images_directory."
			;;
		*JPEG* | *jpeg*)
			echo "$item was identified as a jpg or a jpeg file and will be moved to $images_directory."
			;;
		*PNG*)
			echo "$item was identified as a png file and will be moved to $images_directory."
			;;
		*image* | *Image*)
			echo "$item fell under the catch-all 'images' category and will be moved to $images_directory. This is probably not an incorrect recognition, but verifying would be recommended."
			;;	
		#############################################################################
		*AVI* | *avi*)
			echo "$item was identified as an avi file and will be moved to $video_directory."
			;;
		*Matroska* | *matroska*)
			echo "$item was identified as a mkv file and will be moved to $video_directory."
			;;
		*MP4* | *mp4*)
			echo "$item was identified as an mp4 file and will be moved to $video_directory."
			;;
		*WebM* | *webm*)
			echo "$item was identified as a webm file and will be moved to $video_directory."
			;;
		*video* | *VIDEO*)
			echo "$item fell under the all-catch 'videos' category and will be moved to $video_directory. This is probably not an incorrect recognition, but verifying would be recommended."
			;;		
		#############################################################################
		*tar*)
			echo "$item was identified as a compressed file. It will not be unpacked and will be moved to $unsorted_directory"
			#mv "$item" "$unsorted_directory" || mkdir "$unsorted_directory" && mv "$item" "$unsorted_directory"
			;;
		*Zip* | *zip*)
			echo "$item was identified as a zipped file. It will not be unpacked and will be moved to $unsorted_directory."
			#mv "$item" "$unsorted_directory" || mkdir "$unsorted_directory" && mv "$item" "$unsorted_directory"
			;;
		#############################################################################
		*)
			echo "$item was not recognised and will be placed in $unsorted_directory."
			#mv "$item" "$unsorted_directory" || mkdir "$unsorted_directory" && mv "$item" "$unsorted_directory"
			;;
	esac
}


find "$dir_to_search" -maxdepth 1 -type f -exec echo {} > "$dir_to_search/auto_organiser_temp.txt" \;

while IFS= read -r line
do
  move_to_dir "$line"
done < "$dir_to_search/auto_organiser_temp.txt"

echo $DATE
#rm "${dir_to_search}"/auto_organiser_temp.txt""
