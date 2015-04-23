#!/bin/bash

DOMAIN=$1
LASTRUN="$DOMAIN.html"
THISRUN="$DOMAIN.html.tmp"
DIFFRESULT="$DOMAIN.diff"
EMAIL="kyle.richardson@fnfg.com"
CURLCMD="curl -s -L -U dfir:Fnfg!6950"

cd $HOME/dommon

`$CURLCMD -o $THISRUN $DOMAIN`

diff $LASTRUN $THISRUN > $DIFFRESULT

if [ -s $DIFFRESULT ]
then
	`$CURLCMD -I -o head.txt $DOMAIN`
	cat head.txt $THISRUN > report.txt
	echo "$DOMAIN has changed!" | mailx -a report.txt -s "Monitored Domain Activity" $EMAIL
	rm head.txt report.txt
fi

mv $THISRUN $LASTRUN
rm $DIFFRESULT

exit 0

