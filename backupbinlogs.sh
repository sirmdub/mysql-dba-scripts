#!/bin/bash

if [ -z $1 ]; then #default to standard location
 export BINLOGSDIR=/opt/mysql/data
else
 export BINLOGSDIR=$1
fi

export INDEXFILE=`hostname`-bin.index
export BINLOGSINDEX=$BINLOGSDIR/$INDEXFILE
export BACKUPDIR=/opt/mysql/db_backup/`hostname`/arch_binlogs/
mkdir -p $BACKUPDIR
export DATEAPPEND=`date +'%Y%m%d_%H%M%S'`

#rotate the curent log
mysql -e "flush binary logs"

#cp all binlogs except for current one (last row in index file)
time for i in $(head -n -1 $BINLOGSINDEX); do 
   if [ ! -f $BACKUPDIR/`basename $i`.gz ] 
   then
      echo $i;
      gzip -cv $BINLOGSDIR/`basename $i` > $BACKUPDIR/`basename $i`.gz
   fi
done

cp -v $BINLOGSINDEX $BACKUPDIR/mysql-bin.index.$DATEAPPEND

mysql -e "purge binary logs before adddate(current_timestamp(), interval -1 day)"
mysql -e "show binary logs"

#keep 1 week of backups
find $BACKUPDIR -name "mysql-bin*" -mtime +6 -exec rm {} \;

