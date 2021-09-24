#!/bin/bash

################################################################
## MySQL Maintenance All User Databases
################################################################

MYSQL_USER='mysql_user'
MYSQL_PASSWORD='mysql_password'
LOGFILE=/opt/logs/mysql_maintenance_$(date +%d%m%Y).log

for db in $(mysql -B -s -u $MYSQL_USER -p${MYSQL_PASSWORD} -e 'show databases' --skip-column-names | grep -Ev "(Database|information_schema|performance_schema|sys|mysql)")
do
	echo "Maintenance database $db"

	mysqlcheck -h localhost -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --check --databases ${db} >> ${LOGFILE}

	mysqlcheck -h localhost -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --repair --databases ${db} >> ${LOGFILE}

	mysqlcheck -h localhost -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --optimize --databases ${db} >> ${LOGFILE}

	mysqlcheck -h localhost -u ${MYSQL_USER} -p${MYSQL_PASSWORD} --analyze --databases ${db} >> ${LOGFILE}
done
