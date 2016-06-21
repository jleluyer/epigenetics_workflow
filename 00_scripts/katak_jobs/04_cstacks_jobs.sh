#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="cstacks"
#SBATCH -o log-cstacks.out
#SBATCH -c 5
#SBATCH -p ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=2-00:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR


./00_scripts/03_cstacks.sh
