#!/bin/bash
#PBS -A userID
#PBS -N bismark_methyl
#PBS -o bismark_methyl.out
#PBS -e bismark_methyl.err
#PBS -l walltime=24:00:00
#PBS -M userEmail
#PBS -m ea 
#PBS -l nodes=1:ppn=8
#PBS -r n

: 'usage
bismark_genome_preparation [options] <arguments>

'



#prerequisites
module load compilers/gcc/4.8
module load apps/mugqic_pipeline/1.4 
module load mugqic/bismark/0.14.5
module load mugqic/bowtie2/2.2.6
module load mugqic/bowtie/1.1.2
module load mugqic.bamtools/1.2

#variable
PWD="__PWD__"
PATHTOFILE="03_trimmed"
PATHOUTPUT="05_results"
GENOMEFOLDER="04_reference"
NCPU=8

cd $PWD

#Methylation calling
bismark_methylation_extractor -s --bedGraph --scaffolds --cytosine_report \
		 --genome_folder "$GENOMEFOLDER" \
 		--multicore "$NCPU" -o "$PATHOUTPUT" \
		"$PATHTOFILE"/"$base"_bismark_bt2.bam 2>&1 | tee 98_log_files/"$TIMESTAMP"_methyl.log
