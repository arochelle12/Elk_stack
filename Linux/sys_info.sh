#!/bin/bash


ouput=/home/sysadmin/research/sys_info.txt
ip=ip addr | head -9 | grep inet | tail -l
glr=find ~/ -type f -perm 777


if [ $UID = 0 ]
then
  echo "Please do not run this script as root"
  exit
fi


if [ !-d /home/sysadmin/research ]
then
  mkdir /home/sysadmin/research
fi

if [ -f $output ]
then
  rm $output
fi

ouput=~/research/sys_info.txt

echo "A Quick System Audit"\n >> $ouput
date >> $ouput
echo "Machine Type Info:" >> $ouput
echo $MACHTYPE\n >> $ouput
echo -e "Uname info: $(uname -a)"\n >> $output
echo "The ip info: $ip" >> $ouput
echo "The host name is $(hostname -s)" >> $ouput
echo $HOSTNAME >> $ouput
echo -e \n"Files that are executeable" >> $ouput
echo $glr >> $ouput
echo -e \n"Top 10 Processes" >> $ouput
ps aux | head >> $ouput


# This prints the permissions of the shadow and passwd files
files=(
  '/etc/shadow' 
  '/etc/passwd'
)
for file in ${files[@]}
do
    ls -l $file >> $ouput
done
# To run this in the command line, use ; instead of line breaks like this:
# for user in $(ls /home); do sudo -lU $user; done


#This checks the sudo abilites of each user
for user in $(ls /home)
do
    sudo -lU $user
done


#This shows the results of some common commands:
commands=$('date''uname -a''hostname -s')
for command in ${commands[@]}
do
    echo "The results of the $command are:"
    do
        $command 
    done
done

#Another way of doing the above script (instructor's way):
commands=$('date''uname -a''hostname -s')
for x in {0..2}
do
   results=$(${commands[$x]})
   echo "Results of the \"${commands[$x]}\" command:"
   echo $results
   echo " "
done
