#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="trim_galore"
#SBATCH -o log-trimgalore.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=0-20:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR


./00_scripts/01_trim_galore.sh
