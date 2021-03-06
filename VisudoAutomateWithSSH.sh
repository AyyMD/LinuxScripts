#!/bin/bash
#### Get Host Name ####
echo 'enter hostname in "enXXXXXXXl" format'
read -r HOST
HOST='techs@'$HOST'.cidse.dhcp.asu.edu'

#### Connect to the System ####
echo 'Enter Techs password When Prompted'
ssh -t "$HOST" '
#### Run Commands ####
echo "Please enter groupname without prefix"
echo "The standad lab admin groupname is: \"CIDSE-<professor ASUAD>_Lab_Admins\""
echo "Example: CIDSE-adoipe1_Lab_Admins"
read -r Group
Group="%FULTON\\\\\\$Group	ALL=(ALL:ALL) ALL"
CidseItGroup='\''%FULTON\\\cidse-it	ALL=(ALL:ALL) ALL'\''
# add to the sudo file
sudo cat /etc/sudoers > /etc/sudoers.tmp
sudo echo "$Group" >> -a /etc/sudoers.tmp
sudo echo "$CidseItGroup" >> -a /etc/sudoers.tmp
clear
echo "Output of sudoers file"
echo
sudo cat /etc/sudoers.tmp
echo
echo "Does the contents of the file look correct? [y/N]"
read -r answer

if [[ $answer = [yY] ]]; then
    sudo cp /etc/sudoers.tmp /etc/sudoers
else
    echo "Not commiting changes. Now exiting"
fi
sudo rm /etc/sudoers.tmp
'
