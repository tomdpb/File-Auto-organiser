# File-Auto-organiser
This is a shell script which will automatically move files in the "Downloads" folder to their specific folders based on the file type.
As of 09/01/2021, it's functional. Currently the code is briefly explained through comments and help can be called by passing the `-h` argument when calling the function.
There are plans of perhaps porting it to other languages.
## For UNIX Systems
By modifying the code and adding a loop, this script can be used as a daemon. My recommendation, however, is to schedule it with a *cron job* so it runs at whatever interval the user wishes. That way, despite it being the functionality of the code, files don't get moved immediately and possibly accidentally.
This task scheduling can be done simply with `crontab -e`
