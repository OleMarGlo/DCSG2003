

#!bin/bash

openstack server start backup

sleep 20

ssh Backup 'sudo mount /dev/vdb /mnt'

ssh db1 'rm -rf /home/ubuntu/backup/*'
ssh db1 'rm -rf /home/ubuntu/zippedFiles/*'


ssh db1 'python3 /home/ubuntu/bookface/tools/backup_db.py --output-dir /home/ubuntu/backup'

ssh db1 'tar czf /home/ubuntu/zippedFiles/bfdata_backup.tgz /home/ubuntu/backup'

ssh db1 'scp /home/ubuntu/zippedFiles/bfdata_backup.tgz backup:/home/ubuntu/'
ssh Backup 'sudo mv /home/ubuntu/bfdata_backup.tgz /mnt/'

sleep 10

openstack server stop backup
