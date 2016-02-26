#!/bin/bash

#Set variables for time, measured in seconds
seconds_1h=3600
seconds_1d=$(($seconds_1h * 24))
seconds_1w=$(($seconds_1d * 7))
seconds_30d=$(($seconds_1d * 30))
seconds_1y=$(($seconds_1d * 365))

#Other variables, change as needed
CERT_FILE=/etc/nginx/ssl/certs.dat
RECIPIENT=youremail@example.com
HOSTNAME=`hostname`

#check for certs expiring in 30 days or less, get their names and expiration dates
while read CERTS; do
  cert_name=`openssl x509 -subject -noout -in $CERTS | sed 's/^subject.*CN=\([a-zA-Z0-9\.\-\*]*\).*$/\1/'`
  cert_date=`openssl x509 -enddate -noout -in $CERTS | sed 's/.*=//'`
  if openssl x509 -checkend $seconds_30d -noout -in $CERTS
  then
    :
  else
    temp_30d="$temp_30d$cert_name will expire on $cert_date\n"                                                         
  fi
done < $CERT_FILE

#check for certs expiring in 1 year or less, get their names and expiration dates
#this is commented out because 1 year is too long, mainly used for testing
#while read CERTS; do
#  cert_name=`openssl x509 -subject -noout -in $CERTS | sed 's/^subject.*CN=\([a-zA-Z0-9\.\-\*]*\).*$/\1/'`
#  cert_date=`openssl x509 -enddate -noout -in $CERTS | sed 's/.*=//'`
#  if openssl x509 -checkend $seconds_1y -noout -in $CERTS
#  then
#    :
#  else
#    temp_1y="$temp_1y$cert_name will expire on $cert_date\n"
#  fi
#done < $CERT_FILE

#if variables exist and are set to something, email to alert
#the "-e" in the echo command parses the "\n" linebreaks above
if [ -n "$temp_30d" ] 
then
  echo -e $temp_30d | mail -s "Certificates expiring in 30 days or less on $HOSTNAME" -r "donotreply@$HOSTNAME" $RECIPIENT
elif [ -n "$temp_1y" ]
then
  echo -e $temp_1y | mail -s "Certificates expiring in 1 year or less on $HOSTNAME" -r "donotreply@$HOSTNAME" $RECIPIENT
else
    :
fi


exit
