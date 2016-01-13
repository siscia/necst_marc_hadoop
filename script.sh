#!/bin/bash

dimension="$1"
blocksize="$2"
replication="$3"
directory="$4"
heartbeat="$5"
idmacchina="$6"
uuid="$7"

HADOOP_DIR="/opt/hadoop-3.0.0-SNAPSHOT/share/hadoop/mapreduce/"

echo "$blocksize"
echo "$replication"

hadoop jar $HADOOP_DIR/hadoop-mapreduce-examples-3.0.0-SNAPSHOT.jar \
	teragen \
	-Ddfs.blocksize="$blocksize" \
	-Ddfs.replication="$replication" \
	"$dimension" \
	"$directory" 


