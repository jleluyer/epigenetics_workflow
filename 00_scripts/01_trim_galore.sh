#!/bin/bash



'''usage
trim_galore [options] <filename(s)>
'''


PWD="__PWD__"
cd $PWD

#variables
LENGTH=90
QUAL=20
ERROR_RATE="0.2"
base=__BASE__

trim_galore --rrbs --length $LENGTH --no_report_file -e $ERROR_RATE --illumina -q $QUAL $base

