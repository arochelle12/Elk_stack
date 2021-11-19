# Archiving and Logging Data

## Create, Extract, Compress, and Manage tar Backup Archives
1.	Command to extract the TarDocs.tar archive to the current directory: 
    ```tar xvf TarDocs.tar```
2.	Command to create the Javaless_Doc.tar archive from the TarDocs/ directory, while excluding the TarDocs/Documents/Java directory:
    ```tar cvf Javaless_Docs.tar –exclude=’TarDocs/Documents/Java’ TarDocs/Documents```
3.	Command to ensure Java/ is not in the new Javaless_Docs.tar archive:
    ```tar tvf Javaless_Docs.tar```

## Bonus
1.	Command to create an incremental archive called logs_backup_tar.gz with only changed files to snapshot.file for the /var/log directory:
    ```sudo tar cvvWf logs_backup.tar –listed-incremental=logs_backup.snar –level=0 /var/logs```

## Critical Analysis Question
1.	Why wouldn't you use the options -x and -c at the same time with tar?
    > Because they basically do the opposite of each other. -c is used to create an archive by putting all files/directories into a tar, while -x is used to extract an archive by pulling out all files/directories in a tar. 
***
## Create, Manage, and Automate Cron Jobs
1.	Cron job for backing up the /var/log/auth.log file:
    ```0 18 * * 3 tar -zcf /auth_backup.tgz -P /var/log/auth.log```
***
## Write Basic Bash Scripts
1.	Brace expansion command to create the four subdirectories:
    ```mkdir ~/backups/{freemem,disuse,openlist,freedisk}```
2.	Paste your system.sh script edits below:
    ```
    #!/bin/bash
    # This prints free memory and saves in the backups directory:
    free -h >>  ~/backups/freemem/free_mem.txt
    # This prints disk usage and saves in the backups directory:
    df -h >> ~/backups/diskuse/disk_use.txt
    # This lists all open files and saves in the backups directory:
    lsof >> ~/backups/openlist/open_list.txt
    # This prints file system disk space statistics and saves in the backups directory:
    du -h >> ~/backups/freedisk/free_disk.txt
    ```
3.	Command to make the system.sh script executable:
    ```chmod +x system.sh```

## Optional
1.	Commands to test the script and confirm its execution:
    ```
    head backups/diskuse/disk_use.txt
    head backups/freedisk/free_disk.txt
    head backups/freemem/free_mem.txt
    head backups/openlist/open_list.txt
    ```
***
## Manage Log File Sizes
1.	Run sudo nano /etc/logrotate.conf to edit the logrotate configuration file.
    Configure a log rotation scheme that backs up authentication messages to the /var/log/auth.log.
    Add your config file edits below:
    ```
    /var/log/auth.log {
         rotate 49
         weekly
         notifempty
         delaycompress
         missingok
    }
    ```
