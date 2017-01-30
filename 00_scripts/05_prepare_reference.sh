#!/bin/bash
#SBATCH -J "EPI_masking"
#SBATCH -o log_preparegenome
#SBATCH -c 1
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=YOUREMAIL
#SBATCH --time=8-00:00
#SBATCH --mem=80000

# Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR

#global variables
GENOME="/home/jelel8/Databases/genome/Okisutch/V1/Okis_V1_Chromosomes_and_Unmapped_Scaffolds1.1.fasta"

GENOME_MASK="04_reference/reference_genome.fasta"

#SOFT="-soft"		Enforce "soft" masking.  That is, instead of masking with Ns,
#               	mask with lower-case bases.

#MASK_CHR="-mc" 	#Replace masking character.  That is, instead of masking
#               	with Ns, use another charac

FORMAT_INFO="/home/jelel8/Databases/snp_db/okis_southernBC_SNPs_Jan25-2017_maf0.05_CT.bed" #BED/GFF/VCF file of ranges to mask in -fi



#script
bedtools maskfasta $SOFT $MASK_CHR -fi $GENOME -fo $GENOME_MASK -bed $FORMAT_INFO

