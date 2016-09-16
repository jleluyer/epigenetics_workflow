library(devtools)
library(methylKit)
library (graphics)
library(tools)

### methylkit from sam alignments ###
setwd("05_results/")

#define function (https://gist.github.com/al2na/4839e615e2401d73fe51)

##########
# readBismarkCytosineReport function
devtools::source_gist("4839e615e2401d73fe51",filename="readBismarkFiles.R")
file.list = list("32_CpG_report.txt","5_CpG_report.txt","9_CpG_report.txt")
myobj = readBismarkCytosineReport(file.list,sample.id=c("rrbs3","rrbs42","rrbs23"), assembly="unknown",treatment=c(1,0,2),min.cov=1)

#basis stats
#getMethylationStats(myobj[[2]],plot=T,both.strands=F)
#getCoverageStats(myobj[[2]],plot=T,both.strands=F)
pdf(file="Methylkit.01.MethylationStats.Sample01.pdf",width=12,height=12) ; getMethylationStats(myobj[[1]],plot=T,both.strands=T); dev.off()

pdf(file="Methylkit.01.CoverageStats.Sample01.pdf",width=12,height=12) ; getCoverageStats(myobj[[1]],plot=T,both.strands=T); dev.off()
#filtering for read coverage
filtered.myobj=filterByCoverage(myobj,lo.count=10,lo.perc=NULL,hi.count=NULL,hi.perc=99.9)

##Comparison analysis
#merging
meth=unite(myobj, destrand=FALSE)

#correlation
getCorrelation(meth,plot=FALSE)
pdf(file="Methylkit.02.Meth_CorrelationPlot.pdf",width=12,height=12); getCorrelation(meth,plot=T); dev.off()

#clustering
pdf(file="Methylkit.03.PCASamples.ctreeplot.pdf",width=12,height=12); clusterSamples(meth, dist="correlation", method="ward", plot=TRUE); dev.off()

#optionnal: work with dendogramms: hc = clusterSamples(meth, dist="correlation", method="ward", plot=FALSE)

#PCA
pdf(file="Methylkit.03.PCASamples.screeplot.pdf",width=12,height=12); PCASamples(meth, screeplot=TRUE); dev.off()

# principal component anlaysis of all samples.
pdf(file="Methylkit.03.PCASamples.pcaxyplot.pdf",width=12,height=12); PCASamples(meth); dev.off()

