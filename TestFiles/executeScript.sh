#!bin/bash
## executeScript.sh

./paramFile.sh

export db_nm=$1
export tbl_nm=$2

export db_loc=${hdfs_bucket_base}/${db_nm}
export tbl_loc=${hdfs_bucket_base}/${db_nm}

gcloud dataproc jobs submit hive --cluster ${cluster_nm} --region ${region_nm} -f createTables.hql
gcloud dataproc jobs submit hive --cluster ${cluster_nm} --region ${region_nm} -f populateTables.hql

gcloud dataproc jobs submit hive --cluster ${cluster_nm} --region ${region_nm} -e "ALTER TABLE ${database_nm}.${table_nm} CHANGE Col_3 Col_3_new int"
