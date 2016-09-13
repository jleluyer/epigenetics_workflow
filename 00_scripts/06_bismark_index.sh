#!/bin/bash


TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"

cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

: 'usage
#bismark_genome_preparation [options] <arguments>
'

#variables
GENOME_FOLDER="04_reference"

#prepare genome
bismark_genome_preparation $GENOME_FOLDER  2>&1 | tee 98_log_files/"$TIMESTAMP"_refindex.log
