# BHEH-SUB-PWNER

This bash script tool, will perform advanced subdomain enumeration using both Amass in Passive Mode, Sublist3r, save the results, it will then probe the subdomains into urls using httpx, save the results in a separate file, it will then resolve all the subdomains into ip addresses using a loop statement with hostname and grep/sed and save the results separately.

# Requirements:

You need to have installed all the below tools:

Install lolcat:
pip install lolcat

Install amass:
https://github.com/OWASP/Amass

Install Sublist3r:
https://github.com/aboul3la/Sublist3r


Install httpx:
https://github.com/projectdiscovery/httpx

# Usage

chmod +x bheh-sub-pwner.sh

./bheh-sub-pwner.sh domains.txt

# Credits:

This code is written by Black Hat Ethical Hacking, is free to use, and you can fork it, and expand it to perform better methodology and workflow! - 2021
