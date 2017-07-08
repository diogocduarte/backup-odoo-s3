# Backup Odoo Server to S3

## Requirements:

- sudo apt-install awscli p7zip-full
- pip install awscli --upgrade --user

## Install:

- aws configure
- git clone <repo-url>
- vim ~/.bkodoorc (add the following vars)
   
>    SERVER_NAME='odoogap-www-server'
>    DB_NAME='database1'
>    DATA_FOLDER='/opt/odoo/data'

```bash
wget -O - https://raw.githubusercontent.com/diogocduarte/backup-odoo-s3/master/install.sh | bash
```

## Troubleshooting

aws (awscli) link might not work.
If you are on Ubuntu add to ~/.profile the following line:

```bash
export PATH=~/.local/bin:$PATH
```

## Usage:

> ./back

## Crontab:

crontab -e (add the following)

```bash
# You might need to add this line
PATH=/opt/odoo/.local/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# m h  dom mon dow   command
30 9 * * * /opt/odoo/.backup/back >/dev/null 2>&1
```

## Author:

Diogo Duarte <dduarte@odoogap.com>
