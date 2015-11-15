EXPECTED_RESULT="$1 is a mountpoint"
STATUS=`mountpoint $1`

echo $STATUS

if [[ $STATUS == $EXPECTED_RESULT ]]; then
	exit 0;
else
	exit 1;
fi

