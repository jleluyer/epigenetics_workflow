#!/usr/bin/env python
# extract fasta sequence by their position
# Downloaded from http://www.bioinformatics-made-simple.com/2013/10/actually-i-have-hundreds-of-protein.html
import sys
import re

FASTA= sys.argv[1]
BED= sys.argv[2]

fasta= open(FASTA, 'U')
fasta_dict= {}
for line in fasta:
    line= line.strip()
    if line == '':
        continue
    if line.startswith('>'):
        seqname= line.lstrip('>')
        seqname= re.sub('\..*', '', seqname)
        fasta_dict[seqname]= []
    else:
        fasta_dict[seqname].append(line)

fasta.close()

for seq in fasta_dict:
    fasta_dict[seq] = "".join(fasta_dict[seq])

bed= open(BED, 'U')
for line in bed:
    line= line.strip().split('\t')
    s= int(line[1])
    e= int(line[2]) + 1
    if s < 0:
        s = 0
    snp_pos = float(e - s + 1) / 2
    outname= line[0] + ':' + line[1] + '-' + line[2] + '_pos:' + str(snp_pos)
    print('>' + outname)
    print(fasta_dict[line[0]][s:e])
bed.close()
