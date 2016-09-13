#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="index"
#SBATCH -o log-index.out
#SBATCH -c 1
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR


./00_scripts/06_bismark_index.sh
