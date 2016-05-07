#!/bin/bash
#PBS -A userID
#PBS -N bismark_index
#PBS -o bismark_index.out
#PBS -e bismark_index.err
#PBS -l walltime=24:00:00
#PBS -M userEmail
#PBS -m ea 
#PBS -l nodes=1:ppn=8
#PBS -r n


TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)

# Copy script as it was run
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98-log_files"

cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#prerequisites
module load compilers/gcc/4.8
module load apps/mugqic_pipeline/1.4 
module load mugqic/bismark/0.14.5
module load mugqic/bowtie2/2.2.6
module load mugqic/bowtie/1.1.2
module load mugqic/samtools/1.2

: 'usage
#bismark_genome_preparation [options] <arguments>
'

#variables
GENOME_FOLDER="04_reference"
N="-N 1"                        #NB_MISMATCHES
L="-L 19"                       #seed length
p="-p 8"                        #THREADS

#prepare genome
bismark_genome_preparation $GENOME_FOLDER  2>&1 | tee 98_log_files/"$TIMESTAMP"_refindex.log
