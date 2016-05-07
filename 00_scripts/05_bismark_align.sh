#!/bin/bash
#PBS -A userID
#PBS -N bismark_align
#PBS -o bismark_align.out
#PBS -e bismark_align.err
#PBS -l walltime=24:00:00
#PBS -M userEmail
#PBS -m ea 
#PBS -l nodes=1:ppn=8
#PBS -r n



#prerequisites
module load compilers/gcc/4.8
module load apps/mugqic_pipeline/1.4 
module load mugqic/bismark/0.14.5
module load mugqic/bowtie2/2.2.6
module load mugqic/bowtie/1.1.2
module load mugqic/samtools/1.2

: 'usage
#bismark [options] <genome_folder> {-1 <mates1> -2 <mates2> | <singles>}
'

#variables
GENOME_FOLDER="/home/leluyer/test_epigenetics/test_reduced_90/genome_reduced"
N="-N 1"			#NB_MISMATCHES
L="-L 19"			#seed length
p="-p 8"			#THREADS
DATAFOLDER="03_trimmed"
base=__BASE__

#aligning
bismark $N $L $p -q $GENOME_FOLDER "$DATAFOLER"/"$base".fq
