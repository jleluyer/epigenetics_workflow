#!/bin/bash

for file in $(ls 03_trimmed|sed 's/.fq.gz//g')

do
base="$(basename $file)"

    toEval="cat 00_scripts/07_bismark_align_parallel.sh | sed 's/__BASE__/$base/g'"
    eval $toEval > ALIGN_"$base".sh
done

# Submit jobs
for i in $(ls ALIGN*sh)
do
    sbatch $i
done
