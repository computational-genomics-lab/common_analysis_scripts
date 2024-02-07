#check the storage on any server 

echo -e "\e[1;34m__________________________________DISK USE SUMMARY______________________________\e[0m"
total=$(df --total | tail -n 1 | awk '{print $2}')
used=$(df --total | tail -n 1 | awk '{print $3}')
available=$(df --total | tail -n 1 | awk '{print $4}')

echo -e "Total Disk Space:\t $(( ${total} / 1024 /1024 )) GB"
echo -e "Used  Disk Space:\t $(( ${used} / 1024 /1024 )) GB"
echo -e "Available Disk Space:\t  $(( ${available} / 1024 /1024 )) GB"
