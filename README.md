#certcheck
Bash script to check expiration date on SSL certificates.
This could be combined with a mailserver to send a message to the user.

##Requirements
Should work with any Linux distro with standard tools installed (openssl, curl, grep, etc...).  
Tested on Ubuntu 14.04.  
Create a file in /etc/nginx/ssl called certs.dat, and list the locations of all your certificates.

##Usage
Example of certs.dat file is below
```
/etc/nginx/ssl/site1.com/unified.crt
/etc/nginx/ssl/site2.com/unified.crt
/etc/nginx/ssl/site3.com/unified.crt
```
