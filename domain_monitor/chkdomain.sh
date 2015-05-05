#!/bin/bash

DOMAIN=$1
LASTRUN="$DOMAIN.html"
THISRUN="$DOMAIN.html.tmp"
DIFFRESULT="$DOMAIN.diff"
EMAIL="me@example.com"

cd $HOME/dommon

curl -s -L -H "Cache-Control: no-cache" $DOMAIN > $THISRUN

diff $LASTRUN $THISRUN > $DIFFRESULT

if [ -s $DIFFRESULT ]
then
	curl -s -L -H "Cache-Control: no-cache" -I $DOMAIN > head.txt
	cat head.txt $THISRUN > report.txt
	echo "$DOMAIN has changed!" | mailx -a report.txt -s "Monitored Domain Activity" $EMAIL
	rm head.txt report.txt
fi

mv $THISRUN $LASTRUN
rm $DIFFRESULT

exit 0

