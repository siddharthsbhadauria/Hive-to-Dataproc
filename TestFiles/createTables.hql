CREATE EXTERNAL TABLE IF NOT EXISTS ${hivevar:database_nm}.${hivevar:table_nm}
(
Col_1 string,
Col_2 date,
Col_3 int)
FIELDS TERMINATED BY '\t'
STORED AS textfile
LOCATION ${hivevar:hdfs_loc};