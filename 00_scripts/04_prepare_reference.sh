#!/bin/bash

zcat 03_trimmed/batch_1.catalog.tags.tsv.gz|grep -v '#'|awk '{print ">"$3"\n"$10}' > 04_reference/reference_catalog.fasta
