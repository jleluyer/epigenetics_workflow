#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="trunc"
#SBATCH -o log-trunc.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR


./00_scripts/02_truncate.sh
