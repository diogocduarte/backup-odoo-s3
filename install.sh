
touch ~/.bkodoorc 
echo "SERVER_NAME='$HOSTNAME-server'" >> ~/.bkodoorc
echo "DB_NAME='v10_dbname'" >> ~/.bkodoorc
echo "DATA_FOLDER='/opt/odoo/.local/share/Odoo'" >> ~/.bkodoorc
echo "S3_URL='s3://bucket_name/folder/'" >> ~/.bkodoorc
echo "SLACK_HOOK='https://hooks.slack.com/services/XX/ZZ'" >> ~/.bkodoorc

