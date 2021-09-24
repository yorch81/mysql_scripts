#!/bin/bash

################################################################
## Simulate MySQL load
################################################################

MYSQL_USER='mysql_user'
MYSQL_PASSWORD='mysql_password'
CONCURRENCY=100
ITERATIONS=1000

mysqlslap --user=${MYSQL_USER} --password=${MYSQL_PASSWORD} --concurrency=${CONCURRENCY}  --iterations=${ITERATIONS}  --query=insert.sql --create=table.sql --delimiter=";"