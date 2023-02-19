#!/bin/bash

if [ -z $1 ]
then
                echo "Usage: ./bheh-sub-pwner.sh <domain list>" | lolcat
                exit 1

fi
echo "++++ Alright, let's fetch us some subdomains using Amass & Sublist3r..." | lolcat

while read line
do
        for var in $line
        do
                echo "enumerating:" $var
                echo "...in progress..." | lolcat
                amass enum -passive -v -d $var > output_amass
                cat output_amass >> subs_amass
                sublist3r -d $var  -o output_sublist3r
                cat output_sublist3r >> subs_sublist3r

                rm output_amass output_sublist3r
        done
done < $1

sort -u subs_amass subs_sublist3r > all_subs
rm subs_amass subs_sublist3r
echo "++++ Domains & Sorted and saved under all_subs" | lolcat
sleep 1
echo "++++ PROBING & FINDING ONLY ALIVE HOSTS!..." | lolcat

cat all_subs | httpx > urls_alive
echo "++++ Probing has been complete, enjoy your alive hosts and URLs under urls_alive..." | lolcat

#echo "++++ Let's see if we can get some subdomain takeovers..."

#takeover -l all_subs -t 10

echo "++++ Converting Subdomains to IP Addresses..." | lolcat
sleep 1
echo "++++ Sorting and removing duplicates..." | lolcat
sleep 1
for i in $(cat all_subs); do nslookup $i | grep "Address" | awk '{print $2}' | sed -n 2p;echo;done > ip_addr
sort -u ip_addr > ip_addr_sorted.txt
rm ip_addr
echo "++++ IP Addresses Saved under: ip_addr_sorted.txt" | lolcat
sleep 1
echo "Code written by Black Hat Ethical Hacking" | lolcat
# Matrix effect
echo "Exiting the Matrix for 5 seconds:" | toilet --metal -f term -F border


R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
B='\033[0;34m'
P='\033[0;35m'
C='\033[0;36m'
W='\033[1;37m'

for ((i=0; i<5; i++)); do
    echo -ne "${R}10 ${G}01 ${Y}11 ${B}00 ${P}01 ${C}10 ${W}00 ${G}11 ${P}01 ${B}10 ${Y}11 ${C}00\r"
    sleep 0.2
    echo -ne "${R}01 ${G}10 ${Y}00 ${B}11 ${P}10 ${C}01 ${W}11 ${G}00 ${P}10 ${B}01 ${Y}00 ${C}11\r"
    sleep 0.2
    echo -ne "${R}11 ${G}00 ${Y}10 ${B}01 ${P}00 ${C}11 ${W}01 ${G}10 ${P}00 ${B}11 ${Y}10 ${C}01\r"
    sleep 0.2
    echo -ne "${R}00 ${G}11 ${Y}01 ${B}10 ${P}11 ${C}00 ${W}10 ${G}01 ${P}11 ${B}00 ${Y}01 ${C}10\r"
    sleep 0.2
done
echo -e "\033[2J\033[?25h" # reset screen
