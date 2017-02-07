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

define function (https://gist.github.com/al2na/4839e615e2401d73fe51)

##########
# readBismarkCytosineReport function

devtools::source_gist("4839e615e2401d73fe51", filename = "readBismarkFiles.R")
#now methylkit implement same function to directly use cytosine rport from bismark ?methRead
devtools::source_gist("4839e615e2401d73fe51")
file.list = list("HI.3767.003.BioO_24.c1820_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.003.BioO_26.c1822_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.007.BioO_31.c1794_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.002.BioO_31.c1795_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.008.BioO_33.c1803_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.005.BioO_33.c1804_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.007.BioO_34.c1813_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.001.BioO_34.c1817_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.003.BioO_38.c1821_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.008.BioO_44.c1810_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.002.BioO_24.cap13_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.002.BioO_26.cap17_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.001.BioO_28.cap22_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.005.BioO_29.cap19_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.007.BioO_29.cap26_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.005.BioO_30.cap21_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.006.BioO_32.cap11_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.004.BioO_32.cap23_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.008.BioO_41.cap06_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.001.BioO_44.cap10_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.001.BioO_24.c4237_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.001.BioO_26.c4239_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.008.BioO_28.c4233_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.006.BioO_28.c4234_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.007.BioO_28.c4245_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.006.BioO_29.c4242_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.004.BioO_30.c4231_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.003.BioO_30.c4244_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.002.BioO_30.c4247_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.007.BioO_38.c4232_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.004.BioO_24.c4258_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.004.BioO_26.c4260_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.005.BioO_28.c4262_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.008.BioO_29.c4263_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.003.BioO_31.c4268_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.006.BioO_33.c4251_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.002.BioO_34.c4252_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.005.BioO_38.c4254_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.006.BioO_41.c4255_R1_trimmed.fq_bismark_bt2.CpG_report.txt",
"HI.3767.004.BioO_44.c4257_R1_trimmed.fq_bismark_bt2.CpG_report.txt")

myobj = readBismarkCytosineReport(file.list,
	sample.id=c("caphat1","caphat2","caphat3","caphat4","caphat5","caphat6","caphat7","caphat8","caphat9","caphat10","capwld1","capwld2","capwld3","capwld4","capwld5","capwld6","capwld7","capwld8","capwld9","capwld10","quihat1","quihat2","quihat4","quihat5","quihat6","quihat7","quihat8","quihat9","quihat10","quiwld1","quiwld2","quiwld3","quiwld4","quiwld5","quiwld6","quiwld7","quiwld8","quiwld9","quiwld10"), 
	assembly="unknown",
	treatment=c(rep(1,10),rep(0,10),rep(1,9),rep(0,10)),
	min.cov=5)

save(myobj, file = "R.objects/myobj.rda")

message ("myobj.done")
#load("R.objects/myobj.rda")
filtering
normalize=normalizeCoverage(myobj)

	#test 10
filtered.myobj.10=filterByCoverage(normalize,lo.count=10,lo.perc=NULL,
                                      hi.count=NULL,hi.perc=99.9)

save(filtered.myobj.10, file = "R.objects/filtered.myobj.10.rda")

	#test 5
filtered.myobj.5=filterByCoverage(normalize,lo.count=5,lo.perc=NULL,
                                      hi.count=NULL,hi.perc=99.9)

save(filtered.myobj.5, file = "R.objects/filtered.myobj.5.rda")


message ("filtered.myobj.done")
#basis stats

##Comparison analysis
merging

tiles=tileMethylCounts(filtered.myobj.5,win.size=1000,step.size=1000)
save(tiles, file = "R.objects/tiles.1000.rda")

message ("tile done")


meth=unite(tiles, destrand=TRUE)

save(meth, file = "R.objects/meth.rda")

write.table(meth, file="dataframe/data.frame.tile1000bp.tsv", sep='\t', quote=FALSE)

perc.meth <- percMethylation(meth)
write.table(perc.meth, file="dataframe/data.frame.tile1000bp.percent.tsv", sep='\t', quote=FALSE)

message("done perc meth")

#include covariates
covariates=data.frame(env=c(rep("cap",20),rep("qui",19)))

myDiff=calculateDiffMeth(meth,covariates=covariates, mc.cores=10)
save(myDiff,file = "R.objects/myDiff.rda")

#load("R.objects/myDiff.rda")
write.table(myDiff, file="dataframe/analyis_diff.tile1000.tsv", sep='\t', quote=FALSE)

message("myDiff done")

my.diffMeth3.trimmed = getMethylDiff(myDiff,difference=15,qvalue=0.05)
write.table(my.diffMeth3.trimmed, file="dataframe/analyis_diff.tile1000.q0.05_diff15.tsv", sep='\t', quote=FALSE)
pdf("Methylkit.04.tile_covariate.DiffMethPerChr.pdf",width=12,height=12); diffMethPerChr(my.diffMeth3.trimmed,plot=TRUE,qvalue.cutoff=0.05,meth.cutoff=10); dev.off()
