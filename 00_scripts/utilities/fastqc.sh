#!/bin/bash

#SBATCH -D ./
#SBATCH --job-name="fastqc"
#SBATCH -o log-fastqc.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=20000

cd $SLURM_SUBMIT_DIR

mkdir fastqc_dir
for file in $(ls 02_data/*.*f*q.gz|sed 's/.f(ast)?q.gz//g')
do
base=$(basename $file)
        mkdir  ./fastqc_dir/"$base"_dir
        fastqc -o ./fastqc_dir/"$base"_dir -f fastq "$base".fastq.gz
done
