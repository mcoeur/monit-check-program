#!/bin/bash
DIR=$(cd "$(dirname $0)" && pwd)
source ${DIR}/../config.cfg

QUERY="SELECT * FROM INFORMATION_SCHEMA.PROCESSLIST WHERE USER='${MYSQL_USER}' AND COMMAND != 'Sleep' AND TIME > ${MYSQL_SLOW_QUERY_THRESHOLD}\G"
LIST=`echo "$QUERY" | mysql -u root -p${MYSQL_PASSWORD}`
QUERYCOUNT=`echo "$LIST" | sed /^$/d | wc -l`

if [ $QUERYCOUNT -gt 0 ] ; then
        echo "Slow queries found"
        echo "$QUERY" | tr -d '\r'
        echo "$LIST" | tr -d '\r'
        exit 1
else
        echo "No slow query found"
        exit 0
fi
exit 0
