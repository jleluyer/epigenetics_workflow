#!/bin/bash

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"


#global variables
DATAFOLDER="03_trimmed"



#for i in $(ls 03_trimmed/*gbs*.fq|sed 's/.fq//g')

#do
#base="$(basename $i)"

#fastx_trimmer -l 90 -z -i "$DATAFOLDER"/"$base".fq -o "$DATAFOLDER"/"$base"_trunc.fq.gz

#done 2>&1 | tee 98_log_files/"$TIMESTAMP"_trunc_gbs.log


for i in $(ls 03_trimmed/*RRBS*.fq.gz|sed 's/.fq.gz//g')
do
base="$(basename $i)"

zcat "$DATAFOLDER"/"$base".fq.gz >"$DATAFOLDER"/"$base".fq

#fastx_trimmer -l 88 -i "$DATAFOLDER"/"$base".fq -o "$DATAFOLDER"/"$base"_trunc.fq

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_trunc_rrbs.log
