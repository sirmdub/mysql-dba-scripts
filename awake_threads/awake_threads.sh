#!/bin/bash

mysql -u root -e "set session sql_log_bin=0; insert into performance_repository.PROCESSLIST_ARCHIVE select current_timestamp,@@hostname, p.* from information_schema.processlist p where p.command not in ('Sleep');"
