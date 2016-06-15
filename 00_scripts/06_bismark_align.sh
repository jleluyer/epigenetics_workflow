#!/bin/bash

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"


cd $SLURM_SUBMIT_DIR

#global variables
GENOME_FOLDER="04_reference"
N="-N 1"			#NB_MISMATCHES
L="-L 19"			#seed length
p="-p 4"			#THREADS
DATAFOLDER="03_trimmed"



for i in $(ls 03_trimmed/*rrbs*|sed 's/.fq.gz//g')

do
base="$(basename $i)"
#zcat "$DATAFOLDER"/"$base".fq.gz > "$DATAFOLDER"/"$base".fq

#aligning
bismark $N $L $p -q $GENOME_FOLDER "$DATAFOLDER"/"$base".fq

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_bis_align.log
