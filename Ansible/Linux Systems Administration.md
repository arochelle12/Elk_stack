# Linux Systems Administration
## Ensure/Double Check Permissions on Sensitive Files
Permissions on /etc/shadow should allow only root read and write access.
1. Command to inspect permissions: 
    > ls -l /etc/shadow
2. Command to set permissions (if needed): 
    > sudo chmod 600 /etc/shadow

Permissions on /etc/gshadow should allow only root read and write access.
1. Command to inspect permissions: 
    > ls -l /etc/gshadow
2. Command to set permissions (if needed): 
    > sudo chmod 600 /etc/gshadow

Permissions on /etc/group should allow root read and write access, and allow everyone else read access only.
1. Command to inspect permissions: 
    > ls -l /etc/group
2. Command to set permissions (if needed): 
    > sudo chmod 644 /etc/group

Permissions on /etc/passwd should allow root read and write access, and allow everyone else read access only.
1. Command to inspect permissions: 
    > ls -l /etc/passwd
2. Command to set permissions (if needed): 
    > sudo chmod 644 /etc/passwd
***
## Create User Accounts
Add user accounts for sam, joe, amy, sara, and admin.
1. Command to add each user account (include all five users):
    > sudo adduser sam
    > sudo adduser joe
    > sudo adduser amy
    > sudo adduser sara
    > sudo adduser admin

Ensure that only the admin has general sudo access.
1. Command to add admin to the sudo group: 
    > sudo usermod -aG sudo admin
***
## Create User Group and Collaborative Folder
Add an engineers group to the system.
1. Command to add group: 
    > sudo addgroup enginners

Add users sam, joe, amy, and sara to the managed group.
1. Command to add users to engineers group (include all four users):
    > sudo usermod -aG engineers sam
    > sudo usermod -aG engineers joe
    > sudo usermod -aG engineers amy
    > sudo usermod -aG engineers sara -->

Create a shared folder for this group at /home/engineers.
1. Command to create the shared folder: 
    > sudo mkdir /home/engineers

Change ownership on the new engineers' shared folder to the engineers group.
1. Command to change ownership of engineer's shared folder to engineer group: 
    > sudo chown :engineers /home/engineers
***
## Lynis Auditing
1. Command to install Lynis: 
    > sudo apt install -y lynis
2. Command to see documentation and instructions: 
    > man lynis
3. Command to run an audit: 
    > sudo lynis audit system
***
## Bonus
1. Command to install chkrootkit: 
    > sudo apt install chkrootkit
2. Command to see documentation and instructions: 
    > man chkrootkit
3. Command to run expert mode: 
    > sudo chkrootkit -x 
 
