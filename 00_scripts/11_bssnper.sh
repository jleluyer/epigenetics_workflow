#!/bin/bash
#SBATCH -J "bssnper"
#SBATCH -o log_bssnper
#SBATCH -c 1
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=YOUREMAIL
#SBATCH --time=2-00:00
#SBATCH --mem=100000

# Move to directory where job was submitted
cd $SLURM_SUBMIT_DIR


for i in $(ls 03_trimmed/*_R1_trimmed.fq_bismark_bt2.bam|sed 's/_R1_trimmed.fq_bismark_bt2.bam//g')
do
base="$(basename $i)"

samtools sort input_bam/"$base"_R1_trimmed.fq_bismark_bt2.bam >input_bam/"$base".sort.bam

#Global variables

        REF="--fa /home/jelel8/Databases/genome/Okisutch/okis_uvic.scf.fasta"   #: Reference genome file in fasta format
        INPUT=$(echo "--input 03_trimmed/"$base".sort.bam")           #Input bam file
        OUTPUT=$(echo "--output 03_trimmed/temp."$base".out")                 #Temporary file storing SNP candidates
        CG=$(echo "--methcg "$base".cg")                #CpG methylation information
        CHG=$(echo "--methchg "$base".chg")             #CHG methylation information
        CHH=$(echo "--methchh "$base".chh")             #CHH methylation information
        MINHETFREQ="--minhetfreq 0.05"          #Threshold of frequency for calling heterozygous SNP
        MINHOMFREQ="--minhomfreq 0.90"          #Threshold of frequency for calling homozygous SNP
        MINQUAL="--minquali 10"                 #Threshold of base quality
        MINCOV="--mincover 5"           #Threshold of minimum depth of covered reads
        MAXCOV="--maxcover 2000"                #Threshold of maximum depth of covered reads
        MINREAD="--minread2 1"          #Minimum mutation reads number
        ERR="--errorate 0.02"           #Minimum mutation rate
        MAPVAL="--mapvalue 1"           #Minimum read mapping value
        #SNP.out: Final SNP result file
        #ERR.log: Log file


perl /home/jelel8/test_bs-snper/BS-Snper/BS-Snper.pl $REF $INPUT $OUTPUT $CG $CHH $CHG $MINHETFREQ $MINHOMFREQ $MINQUAL $MINCOV $MAXCOV $MINREAD $ERR $MAPVAL >"$base".out 2>"$base".log

done
