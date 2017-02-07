#!/usr/bin/Rscript

library(devtools)
#install_github("al2na/methylKit", build_vignettes=FALSE, 
#  repos=BiocInstaller::biocinstallRepos(),
 # dependencies=TRUE)
library(methylKit)
library (graphics)
library (tools)
library(GenomicRanges)

# getting counts per region
#regional.methylRaw=regionCounts(object=methylRawList.obj, regions=my.win, 
#cov.bases=0,strand.aware=FALSE)

### methylkit from sam alignments ###
setwd("/home/jelel8/epic4_projects/epigenetics_hatchery/03_epigenetics_workflow/05_results")

## Load objects
load("R.objects/meth.rda")
load("R.objects/myobj.rda")
load("R.objects/filtered.myobj.10.rda")
load("R.objects/filtered.myobj.5.rda")
load("R.objects/myDiff.rda")

#getstats coverage
pdf(file="figures/MethylationStats.myobj.Sample01.pdf",width=12,height=12) ; getMethylationStats(myobj[[1]],plot=T,both.strands=T); dev.off()
pdf(file="figures/CoverageStats.myobj.Sample01.pdf",width=12,height=12) ; getCoverageStats(myobj[[1]],plot=T,both.strands=T); dev.off()

pdf(file="figures/MethylationStats.filtered.myobj.10.Sample01.pdf",width=12,height=12) ; getMethylationStats(filtered.myobj.10[[1]],plot=T,both.strands=T); dev.off()
pdf(file="figures/CoverageStats.filtered.myobj.10.Sample01.pdf",width=12,height=12) ; getCoverageStats(filtered.myobj.10[[1]],plot=T,both.strands=T); dev.off()

pdf(file="figures/MethylationStats.filtered.myobj.5.Sample01.pdf",width=12,height=12) ; getMethylationStats(filtered.myobj.5[[1]],plot=T,both.strands=T); dev.off()
pdf(file="figures/CoverageStats.filtered.myobj.5.Sample01.pdf",width=12,height=12) ; getCoverageStats(filtered.myobj.5[[1]],plot=T,both.strands=T); dev.off()

#clustering
pdf(file="figures/cluster.pdf",width=12,height=12); clusterSamples(meth, dist="correlation", method="ward", plot=TRUE); dev.off()
pdf(file="figures/PCASamples.screeplot.pdf",width=12,height=12); clusterSamples(meth, dist="correlation", method="ward", plot=TRUE); dev.off()

#PCA
# principal component anlaysis of all samples.
pdf(file="figures/Methylkit.tile.PCA.pdf",width=12,height=12); PCASamples(meth); dev.off()

#plot diff per chr
pdf("figures/DiffMethPerChr.pdf",width=12,height=12); diffMethPerChr(myDiff,plot=TRUE,qvalue.cutoff=0.05,meth.cutoff=10); dev.off()

#correlation
pdf(file="figures/CorrelationPlot.pdf",width=12,height=12); getCorrelation(meth,plot=T); dev.off()

#correlation
#getCorrelation(meth,plot=FALSE)
#pdf(file="Methylkit.02.Meth_CorrelationPlot.pdf",width=12,height=12); getCorrelation(meth,plot=T); dev.off()


#get regions counts
#my.win=GRanges(seqnames="chr21",
#ranges=IRanges(start=seq(from=9764513,by=10000,length.out=20),width=5000) )

# getting counts per region
#regional.methylRaw=regionCounts(object=methylRawList.obj, regions=my.win, 
#cov.bases=0,strand.aware=FALSE)
