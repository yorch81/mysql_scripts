#!/bin/bash

################################################################
## MySQL Backup All User Databases
################################################################

MYSQL_USER='mysql_user'
MYSQL_PASSWORD='mysql_password'
BAKDIR=/opt/backups/mysql_backup_$(date +%d%m%Y)/

# Create backup directory
mkdir ${BAKDIR}

for db in $(mysql -B -s -u $MYSQL_USER -p${MYSQL_PASSWORD} -e 'show databases' --skip-column-names | grep -Ev "(Database|information_schema|performance_schema|sys)")
do
	echo "Backuping database $db"

	BAKFILE="${BAKDIR}${db}_$(date +%d%m%Y).sql"

	mysqldump -h localhost -P 3306 -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --single-transaction --routines --add-drop-table --add-drop-database ${db} > ${BAKFILE}
done

# Create zip 
BAKZIP=/opt/zip/mysql_backup_$(date +%d%m%Y).zip

zip -r ${BAKZIP} ${BAKDIR}