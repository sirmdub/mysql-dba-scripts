#!/bin/bash
#pt-heartbeat.test.sh
#
#intended to test for replication lag with percona heartbeat and email alert along with diagnostics
#sample cron: */10 * * * * /root/scripts/pt-heartbeat.test.sh >> /root/scripts/pt-heartbeat.test.log 2>&1
#
export OUTFILE=/tmp/mail.pt-heartbeat.out

date

export CHECK=`pt-heartbeat --database=percona --check --master-server-id=x`
echo $CHECK

export DELAY=`echo $CHECK | awk '$1 > 60'`

if [ -z "$DELAY" ]
then
  echo "no delay"
else
  echo -e "subject: MySQL replication delay on $HOSTNAME\nto: email.recipient@domain.com\n" > $OUTFILE
  echo "delay is $DELAY" >> $OUTFILE
  mysql -e "show slave status \G" >> $OUTFILE
  mysqladmin processlist >> $OUTFILE
  /usr/sbin/sendmail -t < $OUTFILE
fi     

