#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="methyl"
#SBATCH -o log-methyl.out
#SBATCH -c 4
#SBATCH -p ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=2-00:00
#SBATCH --mem=20000

cd $SLURM_SUBMIT_DIR


R -q -e 'source("./00-scripts/")' 2>&1 > /dev/null 
