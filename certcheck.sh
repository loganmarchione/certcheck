#!/bin/bash

#Set variables for seconds
seconds_1h=3600
seconds_1d=$(($seconds_1h * 24))
seconds_1w=$(($seconds_1d * 7))
seconds_30d=$(($seconds_1d * 30))
seconds_1y=$(($seconds_1d * 365))

#Other variables
CERT_FILE=/etc/nginx/ssl/certs.dat

#30 day while loop
echo -e "\n30 day expiration"
while read CERTS; do
  cert_name=`openssl x509 -subject -noout -in $CERTS | sed -e 's/^subject.*CN=\([a-zA-Z0-9\.\-\*]*\).*$/\1/'`
  if openssl x509 -checkend $seconds_30d -noout -in $CERTS
  then
    :
  else
    echo $cert_name
  fi
done < $CERT_FILE

#1 year while loop
echo -e "\n1 year expiration"
while read CERTS; do
  cert_name=`openssl x509 -subject -noout -in $CERTS | sed -e 's/^subject.*CN=\([a-zA-Z0-9\.\-\*]*\).*$/\1/'`
  if openssl x509 -checkend $seconds_1y -noout -in $CERTS
  then
    :
  else
    echo $cert_name
  fi
done < $CERT_FILE


exit
