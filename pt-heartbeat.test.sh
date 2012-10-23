#!/bin/bash
#pt-heartbeat.test.sh
#
#intended to test for replication lag with percona heartbeat and email alert along with diagnostics
#sample cron: */10 * * * * /root/scripts/pt-heartbeat.test.sh >> /root/scripts/pt-heartbeat.test.log 2>&1
#

date

export CHECK=`pt-heartbeat --database=percona --check --master-server-id=101`
echo $CHECK

export DELAY=`echo $CHECK | awk '$1 > 60'`

if [ -z "$DELAY" ]
then
  echo "no delay"
else
  echo -e "subject: MySQL replication delay on $HOSTNAME\nto: michaelw436@gmail.com,jacob@thisorthat.com,matt@thisorthat.com\n" > /tmp/mail.pt-heartbeat.out
  echo "delay is $DELAY" >> /tmp/mail.pt-heartbeat.out
  mysql -e "show slave status \G" >> /tmp/mail.pt-heartbeat.out
  mysqladmin processlist >> /tmp/mail.pt-heartbeat.out
  /usr/sbin/sendmail -t < /tmp/mail.pt-heartbeat.out
fi     

