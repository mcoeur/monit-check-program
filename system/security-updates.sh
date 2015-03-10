#!/bin/bash
UPDATECOUNT=`cat /var/lib/update-notifier/updates-available | grep security | cut -d\  -f 1`
LIMIT=2

if [ -z $UPDATECOUNT ] ; then
	UPDATECOUNT=0;
fi

if  [ $UPDATECOUNT -ge $LIMIT ]; then
        echo "Security update queue exceeded limit ($UPDATECOUNT)"
	cat /var/lib/update-notifier/updates-available
        exit 1;
else
        echo "Security update queue OK ($UPDATECOUNT)"
        exit 0;
fi
