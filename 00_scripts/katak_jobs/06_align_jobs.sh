#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="align"
#SBATCH -o log-bis_align.out
#SBATCH -c 4
#SBATCH -p ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=2-00:00
#SBATCH --mem=20000

cd $SLURM_SUBMIT_DIR


./00_scripts/06_bismark_align.sh
