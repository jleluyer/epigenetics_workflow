#intsall devtools 
library(devtools)
#install_github("al2na/methylKit",build_vignettes=FALSE)
library(methylKit)
library ("graphics")

### methylkit from sam alignments ###
setwd("05_reuslts/output_extractor/")

#define function (https://gist.github.com/al2na/4839e615e2401d73fe51)

##########
# readBismarkCytosineReport function
devtools::source_gist("4839e615e2401d73fe51")
file.list = list(HI.3620.008.RPI24.rrbs_3_R1_trimmed_trunc_bismark_bt2.CpG_report.txt,
HI.3620.008.RPI26.rrbs_42_R1_trimmed_trunc_bismark_bt2.CpG_report.txt,
HI.3620.008.RPI31.rrbs_23_R1_trimmed_trunc_bismark_bt2.CpG_report.txt)
myobj = readBismarkCytosineReport(file.list,sample.id=c("rrbs3","rrbs42","rrbs23"), assembly="unknown",treatment=c(1,0,2),min.cov=1)

#basis stats
getMethylationStats(myobj[[2]],plot=T,both.strands=F)
getCoverageStats(myobj[[2]],plot=T,both.strands=F)

#filtering for read coverage
filtered.myobj=filterByCoverage(myobj,lo.count=10,lo.perc=NULL,hi.count=NULL,hi.perc=99.9)

##Comparison analysis
#merging
meth=unite(myobj, destrand=FALSE)

#correlation
getCorrelation(meth,plot=T)

#clustering
clusterSamples(meth, dist="correlation", method="ward", plot=TRUE)
#optionnal: work with dendogramms: hc = clusterSamples(meth, dist="correlation", method="ward", plot=FALSE)

#PCA
PCASamples(meth, screeplot=TRUE)
PCASamples(meth)
