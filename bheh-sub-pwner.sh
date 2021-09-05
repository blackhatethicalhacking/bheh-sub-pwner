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
