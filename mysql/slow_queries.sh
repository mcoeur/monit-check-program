#!/bin/bash

DIR=$(cd "$(dirname $0)" && pwd)
source ${DIR}/../config.cfg

QUERY="SELECT * FROM INFORMATION_SCHEMA.PROCESSLIST WHERE USER='${MYSQL_USER}' AND COMMAND != 'Sleep' AND TIME > ${MYSQL_MAX_SLOW_QUERY_TIME} "
QUERYCOUNT=`echo "$QUERY" | mysql -u root -p${MYSQL_PASSWORD} | wc -l`
if [ $QUERYCOUNT -gt 0 ] ; then
	echo "Slow queries found ($QUERYCOUNT)" 1>&2
	echo "$QUERY" | mysql -u root -p$PASSWORD 1>&2
	exit 1
else
	echo "No slow query found"
	exit 0
fi
exit 0