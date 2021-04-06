# File-Auto-organiser
This is a shell script which will automatically move files in the "Downloads" folder to specific directories/folders based on their file type. Please note that files in subdirectories will not be touched. That is, any files contained in subdirectories of the searching directory will remain where they are.
The program is also briefly explained through the code comments and help can be called by passing the `-h` argument when calling the program through the terminal.

To change where the files will be moved to and where to search for the files, the variables of the directories must be changed in the code itself. This is not a difficult task to do as the variables are labelled logically. 
Ex: 
* `dir_to_search` is the directory where the program will search for files.
* `audio_directory` is the directory where files identified as *audio* will be moved to.
* `documents_directory` is the directory where files identified as *documents* will be moved to.
*  etc.


## For UNIX Systems
By modifying the code and adding a loop, this script can be used as a daemon using the `check_for_items` function to activate the program's main function. My recommendation, however, is to simply schedule it with a *cron job* so that it runs at whatever time interval the user wishes. That way, despite it being the functionality of the code, files don't get moved immediately and possibly accidentally.

This task scheduling can be done quickly and easily by typing `crontab -e` in the terminal and following the instructions provided by *crontab* to call the *auto_organiser.sh* script.
