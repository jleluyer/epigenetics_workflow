#!/bin/bash

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"


#variables
GENOME="okis_uvic.scf.fasta"
GENOME_FOLDER="04_reference"
OUTPOUT_FOLDER="05_results"
OUTPUT="genome.cpgcheck"


#launch script
cpgplot "$GENOME_FOLDER"/"$GENOME" -window 100 -minlen 200 -minoe 0.6 -minpc 50. -outfile "$OUTPOUT_FOLDER"/"$OUTPUT".cpgplot -graph none -outfeat "$OUTPOUT_FOLDER"/"$OUTPUT".gff
