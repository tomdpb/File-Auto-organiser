# File-Auto-organiser
This is a shell script which will automatically move files in the "Downloads" folder to specific directories/folders based on their file type.
Currently the code is briefly explained through comments and help can be called by passing the `-h` argument when calling the program.

To change where the files will be moved to and where to search for the files, the variables of the directories must be changed in the code itself. This is not a difficult task to do as the variables are labelled logically. 
Ex: 
* `dir_to_search` is where the program will search for files
* `audio_directory` is where files identified as audio will be moved to
*  `documents_directory` is where files identified as documents will be moved to
*  etc.

There are plans of perhaps porting this program to other languages.
## For UNIX Systems
By modifying the code and adding a loop, this script can be used as a daemon. My recommendation, however, is to schedule it with a *cron job* so it runs at whatever time interval the user wishes. That way, despite it being the functionality of the code, files don't get moved immediately and possibly accidentally.

This task scheduling can be done simply with `crontab -e` and following the *crontab* provided instructions.
