#!/bin/bash

set -e 

# Define the file for the hashed username and password
SASL_PASSWD_FILE=/etc/postfix/sasl/smtp_sasl_passwd

# Create the username:password file for Postfix SASL authentication
echo "${SMTP_RELAYHOST} ${SMTP_USERNAME}:${SMTP_PASSWORD}" > $SASL_PASSWD_FILE

# Generate the hashed password file using postmap
postmap hash:$SASL_PASSWD_FILE

# Set proper permissions on the hashed file
chown root:root $SASL_PASSWD_FILE*
chmod 600 $SASL_PASSWD_FILE*

echo "${SMTP_SENDERMAIL}" > /etc/mailname

# Postfix configuration to use the hashed password file
postconf -e "relayhost = ${SMTP_RELAYHOST}"
postconf -e 'smtp_sasl_auth_enable = yes'
postconf -e 'smtp_sasl_security_options = noanonymous'
postconf -e "smtp_sasl_password_maps = hash:$SASL_PASSWD_FILE"
postconf -e "mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 172.20.0.6/32"
postconf -e 'maillog_file = /dev/stdout'

# https://serverfault.com/questions/1003885/postfix-in-docker-host-or-domain-name-not-found-dns-and-docker
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

# Run Postfix in the foreground (this keeps the container running)
postfix start-fg

