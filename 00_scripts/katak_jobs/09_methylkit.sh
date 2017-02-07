#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="methyl"
#SBATCH -o log-methyl.out
#SBATCH -c 4
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=2-00:00
#SBATCH --mem=20000

cd $SLURM_SUBMIT_DIR

Rscript 00_scripts/09_methylkit.R
