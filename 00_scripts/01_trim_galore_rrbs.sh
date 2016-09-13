#!/bin/bash

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"


#variables
LENGTH=88
QUAL=20
ERROR_RATE="0.2"
OUTPUT="03_trimmed"

for file in $(ls 02_data/*.fastq.gz|sed 's/_R1.fastq.gz//g'|grep -v '.md5')
do

base=$(basename $file)

trim_galore --rrbs --length $LENGTH --no_report_file -e $ERROR_RATE --illumina -q $QUAL 02_data/"$base"_R1.fastq.gz -o $OUTPUT

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_trimmgalore_rrbs.log

