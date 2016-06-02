
#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="trim_galore_rrbs"
#SBATCH -o log-trimgalore_rrbs.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR


./00_scripts/01_trim_galore_rrbs.sh
