#!/bin/bash

# Input the instance name

INSTANCENAME_DEFAULT="production-$HOSTNAME"
read -p "Please enter INSTANCENAME [$INSTANCENAME_DEFAULT]: " INSTANCENAME
INSTANCENAME="${INSTANCENAME:-$INSTANCENAME_DEFAULT}"

# Input the database name

DATABASENAME_DEFAULT="v11_production"
read -p "Please enter INSTANCENAME [$DATABASENAME_DEFAULT]: " DATABASENAME
DATABASENAME="${DATABASENAME:-$DATABASENAME_DEFAULT}"

# Input the data folder name

DATAFOLDER_DEFAULT="$HOME/.local/share/Odoo"
read -p "Please enter the Odoo data folder [$DATAFOLDER_DEFAULT]: " DATAFOLDER
DATAFOLDER="${DATAFOLDER:-$DATAFOLDER_DEFAULT}"

# Input the S3 URL

S3URL_DEFAULT="s3://bucket_name/folder/"
read -p "Please enter the S3 url [$S3URL_DEFAULT]: " S3URL
S3URL="${S3URL:-$S3URL_DEFAULT}"

# Input the Slack Hook

SLACKHOOK_DEFAULT="https://hooks.slack.com/services/XX/ZZ"
read -p "Please enter the Slack Hook [$SLACKHOOK_DEFAULT]: " SLACKHOOK
SLACKHOOK="${SLACKHOOK:-$SLACKHOOK_DEFAULT}"

echo "Please check you have runned the following requirements"
echo
echo "## Requirements:"
echo "- sudo apt install p7zip-full"
echo "- pip install awscli --upgrade --user"
echo
echo
echo "Instance name: ${INSTANCENAME} (will show on slack message)"
echo "Database name: ${DATABASENAME}"
echo "Data folder:   ${DATAFOLDER}"
echo "S3 url:        ${S3URL}"
echo "Slack hook:    ${SLACKHOOK}"
echo

read -n1 -r -p 'Confirm and press any key to proceed (or Ctrl-C to halt) ...' key

if [ ! -f ~/.bkodoorc ]; then
    touch ~/.bkodoorc 
    echo "SERVER_NAME='$INSTANCENAME'" >> ~/.bkodoorc
    echo "DB_NAME='$DATABASENAME'" >> ~/.bkodoorc
    echo "DATA_FOLDER='$DATAFOLDER'" >> ~/.bkodoorc
    echo "S3_URL='$S3URL'" >> ~/.bkodoorc
    echo "SLACK_HOOK='$SLACKHOOK'" >> ~/.bkodoorc
fi

if [ ! -f ~/.profile ]; then
    touch ~/.profile
    echo "export PATH=~/.local/bin:$PATH" >> ~/.profile
fi

if [ ! -d ~/.backup/back ]; then
    git clone https://github.com/diogocduarte/backup-odoo-s3.git ~/.backup
    chmod +x ~/.backup/back
fi

# You might need to add this line
croncmd="PATH=$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
( crontab -l | grep -v -F "$croncmd" ; echo "$croncmd" ) | crontab -

# Add to CRONTAB
croncmd="$HOME/.backup/back >/dev/null 2>&1"
cronjob="0 20 * * * $croncmd"
( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -





