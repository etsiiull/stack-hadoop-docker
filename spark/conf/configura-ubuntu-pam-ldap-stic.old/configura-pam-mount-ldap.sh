#!/bin/bash --login


cd /soft/configura-ubuntu-pam-ldap-stic
apt-get install -y sssd ldap-utils
cd files
rsync -av . /
chmod 0600 /etc/sssd/sssd.conf

