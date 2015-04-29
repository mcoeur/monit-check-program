#!/bin/bash

DIR=$(cd "$(dirname $0)" && pwd)
source ${DIR}/../config.cfg

SLAVE_OK_STATUS="Waiting for master to send event"

QUERY="SHOW SLAVE STATUS\G"
STATUS=`echo "$QUERY" | mysql -u root -p${MYSQL_PASSWORD}`

SECONDS_BEHIND_MASTER=`echo "$STATUS" | grep "Seconds_Behind_Master" | cut -d: -f 2 | sed 's/^[ ]*//'`
SLAVE_IO_STATE=`echo "$STATUS" | grep "Slave_IO_State" | cut -d: -f 2 | sed 's/^[ ]*//'`

if [ "${SLAVE_IO_STATE}" != "${SLAVE_OK_STATUS}" ]; then
        echo "Slave status error : "
        echo "$SLAVE_IO_STATE"
        echo "------- complete output ------"
        echo "$STATUS"
        exit 1
elif [ ${SECONDS_BEHIND_MASTER} -gt ${MYSQL_SLAVE_DELAY} ]; then
        echo "Slave too far behind master : "${SECONDS_BEHIND_MASTER}" seconds"
        echo "------- complete output ------"
        echo "$STATUS"
        exit 1
fi

echo "Slave status OK"

exit 0
