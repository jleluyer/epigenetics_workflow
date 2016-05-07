#!/bin/bash
#$ -N log.ustacks
#$ -M userEmail
#$ -m beas
#$ -pe smp 1
#$ -l h_vmem=20G
#$ -l h_rt=60:00:00
#$ -cwd
#$ -S /bin/bash


./00_scripts/02_ustacks.sh
