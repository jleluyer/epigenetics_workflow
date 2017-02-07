#!/usr/bin/Rscript

library(devtools)
#install_github("al2na/methylKit", build_vignettes=FALSE, 
#  repos=BiocInstaller::biocinstallRepos(),
 # dependencies=TRUE)
library(methylKit)
library (graphics)
library (tools)
### methylkit from sam alignments ###
setwd("/home/jelel8/epic4_projects/epigenetics_hatchery/03_epigenetics_workflow/05_results")

#prepare objects do
load("R.objects/filtered.myobj.10.rda")
load("R.objects/filtered.myobj.5.rda")


meth.5=unite(filtered.myobj.5,min.per.group=14L,destrand=FALSE)
save(meth.5, file = "R.objects/meth.5.rda")
write.table(meth.5, file="dataframe/meth.5.tsv", sep='\t', quote=FALSE)

meth.10=unite(filtered.myobj.10,min.per.group=14L,destrand=FALSE)
save(meth.10, file = "R.objects/meth.10.rda")
write.table(meth.10, file="dataframe/meth.10.tsv", sep='\t', quote=FALSE)
