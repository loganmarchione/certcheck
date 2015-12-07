#certcheck
Bash script to check expiration date on SSL certificates.

##Requirements
Should work with any Linux distro with standard tools installed (openssl, curl, grep, etc...).  
Tested on Ubuntu 14.04.

##Usage
The *generate_backups.ksh* script collects all the database information from config files (no entering passwords!) and performs a mysqldump on the databases. The rest of the files are backed up using tar. The script runs out of root's crontab at 5am every morning.

`0 5 * * * /backup/generate_backups.ksh >/dev/null 2>&1`
