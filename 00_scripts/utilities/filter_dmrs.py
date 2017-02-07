#!/usr/bin/python

import sys

orig_stdout = sys.stdout
out = file('05_results/dataframe/data.frame.tile1000bp.percent.3cpg.tsv', 'w')
sys.stdout = out

with open("temp") as f:
    terms = set(line.strip() for line in f)

with open("05_results/dataframe/data.frame.tile1000bp.percent.tsv") as g:
    for line in g:
        l = line.strip().split()
        info = " ".join(l[0:3])
        if info in terms:
            print line.strip()

sys.stdout = orig_stdout
out.close()
