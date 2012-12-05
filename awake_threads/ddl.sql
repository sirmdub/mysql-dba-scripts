create database performance_repository;

CREATE TABLE `performance_repository`.`PROCESSLIST_ARCHIVE` (
  `TS` timestamp default current_timestamp,
  `HOSTNAME` varchar(64),
  `ID` bigint(4) NOT NULL DEFAULT '0',
  `USER` varchar(16) NOT NULL DEFAULT '',
  `HOST` varchar(64) NOT NULL DEFAULT '',
  `DB` varchar(64) DEFAULT NULL,
  `COMMAND` varchar(16) NOT NULL DEFAULT '',
  `TIME` int(7) NOT NULL DEFAULT '0',
  `STATE` varchar(64) DEFAULT NULL,
  `INFO` longtext/*,
  ###percona server###`TIME_MS` bigint(21) NOT NULL DEFAULT '0',
  ###percona server###`ROWS_SENT` bigint(21) unsigned NOT NULL DEFAULT '0',
  ###percona server###`ROWS_EXAMINED` bigint(21) unsigned NOT NULL DEFAULT '0',
  ###percona server###`ROWS_READ` bigint(21) unsigned NOT NULL DEFAULT '0'*/
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8
PARTITION BY RANGE (UNIX_TIMESTAMP(ts))
(
PARTITION p2012_12 values less than (UNIX_TIMESTAMP('2013-01-01 00:00:00')),
PARTITION p2013_01 values less than (UNIX_TIMESTAMP('2013-02-01 00:00:00')),
PARTITION p2013_02 values less than (UNIX_TIMESTAMP('2013-03-01 00:00:00')),
PARTITION p2013_03 values less than (UNIX_TIMESTAMP('2013-04-01 00:00:00')),
PARTITION p2013_04 values less than (UNIX_TIMESTAMP('2013-05-01 00:00:00')),
PARTITION p2013_05 values less than (UNIX_TIMESTAMP('2013-06-01 00:00:00')),
PARTITION p2013_06 values less than (UNIX_TIMESTAMP('2013-07-01 00:00:00')),
PARTITION p2013_07 values less than (UNIX_TIMESTAMP('2013-08-01 00:00:00')),
PARTITION p2013_08 values less than (UNIX_TIMESTAMP('2013-09-01 00:00:00')),
PARTITION p2013_09 values less than (UNIX_TIMESTAMP('2013-10-01 00:00:00')),
PARTITION p2013_10 values less than (UNIX_TIMESTAMP('2013-11-01 00:00:00')),
PARTITION p2013_11 values less than (UNIX_TIMESTAMP('2013-12-01 00:00:00')),
PARTITION p2013_12 values less than (UNIX_TIMESTAMP('2014-01-01 00:00:00')),
PARTITION pmax values less than maxvalue engine=ARCHIVE);

