#!/bin/bash

DIR=$(cd "$(dirname $0)" && pwd)
source ${DIR}/../config.cfg

UPDATECOUNT=`cat /var/lib/update-notifier/updates-available | grep security | cut -d\  -f 1`
echo "threshold : "${SECURITY_UPDATES_THRESHOLD}

if [ -z $UPDATECOUNT ] ; then
	UPDATECOUNT=0;
fi

if  [ $UPDATECOUNT -ge ${SECURITY_UPDATES_THRESHOLD} ]; then
        echo "Security update queue exceeded limit ($UPDATECOUNT)"
	cat /var/lib/update-notifier/updates-available
        exit 1;
else
        echo "Security update queue OK ($UPDATECOUNT)"
        exit 0;
fi
