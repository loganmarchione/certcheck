# certcheck
Bash script to check expiration date on SSL certificates.  
Emails user(s) to alert of expiring certificates.

## Requirements
Should work with any Linux distro with standard tools installed (openssl, curl, grep, etc...).  
Requires a MTA (such as Exim4 or Postfix). My setup is described [here](https://loganmarchione.com/2015/03/digitalocean-lemp-wordpress/#Enable_email).  
Tested on Ubuntu 14.04.  
Create a file in /etc/nginx/ssl called certs.dat, and list the locations of all your certificates (example below).

## Usage
Example of certs.dat file is below.
```
/etc/nginx/ssl/site1.com/unified.crt
/etc/nginx/ssl/site2.com/unified.crt
/etc/nginx/ssl/site3.com/unified.crt
```

Example of email is below.
```
Subject:
Certificates expiring in 1 year or less on web01

Body:
www.site1.com will expire on Apr 17 07:56:04 2016 GMT
www.site2.com will expire on Nov  6 09:21:27 2016 GMT
www.site3.com will expire on Apr 14 00:11:28 2016 GMT
```

The script runs out of root's crontab three times a month.  

`0 2 1,15,31 * * /scripts/certcheck/certcheck.sh`
