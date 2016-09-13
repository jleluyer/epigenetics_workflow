#!/bin/bash
#SBATCH -D ./ 
#SBATCH --job-name="align"
#SBATCH -o log-bis_align__BASE__.out
#SBATCH -c 4
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=2-00:00
#SBATCH --mem=20000

cd $SLURM_SUBMIT_DIR


TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#global variables
GENOME_FOLDER="04_reference"
N="-N 1"			#NB_MISMATCHES
L="-L 19"			#seed length
p="-p 4"			#THREADS
DATAFOLDER="03_trimmed"
base=__BASE__


zcat "$DATAFOLDER"/"$base".fq.gz > "$DATAFOLDER"/"$base".fq

#aligning
bismark $N $L $p -q $GENOME_FOLDER "$DATAFOLDER"/"$base".fq

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_"$base"_bis_align.log
