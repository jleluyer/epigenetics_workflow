#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="EPIextract"
#SBATCH -o log-extract.out
#SBATCH -c 4
#SBATCH -p low-cancel
####SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=2-00:00
#SBATCH --mem=20000

cd $SLURM_SUBMIT_DIR


./00_scripts/08_bismark_CpG_extractor.sh
