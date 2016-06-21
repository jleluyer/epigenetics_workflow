#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="index"
#SBATCH -o log-index.out
#SBATCH -c 4
#SBATCH -p ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR


./00_scripts/05_bismark_index.sh
