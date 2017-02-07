#!/bin/bash

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#prerequisites
module load bamtools/2.4.0

#Global variables
PATHOUTPUT="/home/jelel8/epic4_projects/epigenetics_hatchery/03_epigenetics_workflow/05_results/output_extractor/"
GENOMEFOLDER="/home/jelel8/epic4_projects/epigenetics_hatchery/03_epigenetics_workflow/04_reference/"
PATHTOFILE="/home/jelel8/epic4_projects/epigenetics_hatchery/03_epigenetics_workflow/05_results"
NCPU=4


for i in $(ls 05_results/output_extractor/*_bismark_bt2.bam)

do

file="$(basename $i)"

#Methylation calls
bismark_methylation_extractor -s --bedGraph --scaffolds --cytosine_report --genome_folder "$GENOMEFOLDER" --multicore "$NCPU" -o "$PATHOUTPUT" "$PATHTOFILE"/"$file"

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_methyl.log
