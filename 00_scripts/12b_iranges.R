#!/usr/bin/Rscript

library(GenomicRanges)


#load Data
data216dmr <-read.table("05_results/dataframe/iranges/GRange_dmr216.txt",header=T,sep="\t")
dataCpG.5 <-read.table("05_results/dataframe/iranges/GRange_meth5.txt",header=T,sep="\t")
dataCpG.10 <-read.table("05_results/dataframe/iranges/GRange_meth10.txt",header=T,sep="\t")
datatrans <-read.table("05_results/dataframe/iranges/GRange_trans.txt",header=T,sep="\t")
datadmr <-read.table("05_results/dataframe/iranges/GRange_dmr.txt",header=T,sep="\t")
#dataSNP<-read.table("~/Desktop/data_epi/list_Iranges_snp.txt", header=T)

#load("~/Desktop/myobj.Rda")
#load library
library(GenomicRanges)

#total dmr
dmr<-makeGRangesFromDataFrame(datadmr,
                                        keep.extra.columns=FALSE,
                                        ignore.strand=TRUE,
                                        seqinfo=NULL,
                                        seqnames.field="chr",
                                        start.field="start",
                                        end.field="end",
                                        strand.field="strand",
                                        starts.in.df.are.0based=FALSE)

dmr216<-makeGRangesFromDataFrame(data216dmr,
                                        keep.extra.columns=FALSE,
                                        ignore.strand=TRUE,
                                        seqinfo=NULL,
                                        seqnames.field="chr",
                                        start.field="start",
                                        end.field="end",
                                        strand.field="strand",
                                        starts.in.df.are.0based=FALSE)
# CpG bases
cpg_5<-makeGRangesFromDataFrame(dataCpG.5,
                                   keep.extra.columns=FALSE,
                                   ignore.strand=TRUE,
                                   seqinfo=NULL,
                                   seqnames.field="chr",
                                   start.field="start",
                                   end.field="end",
                                   strand.field="strand",
                                   starts.in.df.are.0based=FALSE)

# CpG bases 10cov 14L
cpg_10<-makeGRangesFromDataFrame(dataCpG.10,
                                        keep.extra.columns=FALSE,
                                        ignore.strand=TRUE,
                                        seqinfo=NULL,
                                        seqnames.field="chr",
                                        start.field="start",
                                        end.field="end",
                                        strand.field="strand",
					starts.in.df.are.0based=FALSE)

#SNP database
#snpbase<-makeGRangesFromDataFrame(database,
 #                             keep.extra.columns=TRUE,
  #                            ignore.strand=TRUE,
   #                           seqinfo=NULL,
    #                          seqnames.field="chr",
     #                         start.field="start",
      #                        end.field="end",
       #                       strand.field="strand",
        #                      starts.in.df.are.0based=FALSE)

# 5kb genes
#transranges5kb<-makeGRangesFromDataFrame(datatrans,
 #                                     keep.extra.columns=TRUE,
  #                                    ignore.strand=TRUE,
   #                                   seqinfo=NULL,
    #                                  seqnames.field="Chr",
     #                                 start.field="Start",
      #                                end.field="End",
       #                               strand.field="Strand",
        #                              starts.in.df.are.0based=FALSE)
#start(transranges5kb)<-start(transranges5kb) - 5000
#end(transranges5kb)<-end(transranges5kb) + 5000

# trans 2kb
#transranges2kb<-makeGRangesFromDataFrame(datatrans,
 #                                        keep.extra.columns=TRUE,
  #                                       ignore.strand=TRUE,
   #                                      seqinfo=NULL,
    #                                     seqnames.field="Chr",
     #                                    start.field="Start",
      #                                   end.field="End",
       #                                  strand.field="Strand",
        #                                 starts.in.df.are.0based=FALSE)
#start(transranges2kb)<-start(transranges2kb) - 2000
#end(transranges2kb)<-end(transranges2kb) + 2000

#cpcranges<-makeGRangesFromDataFrame(dataCpG,
 #                                   keep.extra.columns=FALSE,
  #                                  ignore.strand=FALSE,
   #                                 seqinfo=NULL,
    #                                seqnames.field="Chr",
     #                               start.field="Start",
      #                              end.field="End",
       #                             strand.field="Strand",
        #                            starts.in.df.are.0based=FALSE)

#CpG ranges shores
#cpcranges2kb<-makeGRangesFromDataFrame(dataCpG,
 #                                   keep.extra.columns=FALSE,
  #                                  ignore.strand=FALSE,
   #                                seqinfo=NULL,
    #                                seqnames.field="Chr",
    #                                start.field="Start",
     #                               end.field="End",
      #                              strand.field="Strand",
       #                             starts.in.df.are.0based=FALSE)
#start(cpcranges2kb)<-start(cpcranges2kb) - 2000
#end(cpcranges2kb)<-end(cpcranges2kb) + 2000

#cpg ranges 4kb
#cpcranges4kb<-makeGRangesFromDataFrame(dataCpG,
 #                                   keep.extra.columns=FALSE,
  #                                  ignore.strand=TRUE,
   #                                 seqinfo=NULL,
    #                                seqnames.field="Chr",
     #                               start.field="Start",
      #                              end.field="End",
       #                             strand.field="Strand",
        #                            starts.in.df.are.0based=FALSE)
#start(cpcranges4kb)<-start(cpcranges4kb) - 4000
#end(cpcranges4kb)<-end(cpcranges4kb) + 4000

#transgenic
#transranges<-makeGRangesFromDataFrame(datatrans,
 #                                   keep.extra.columns=TRUE,
  #                                  ignore.strand=TRUE,
   #                                 seqinfo=NULL,
    #                                seqnames.field="Chr",
     #                               start.field="Start",
      #                              end.field="End",
       #                             strand.field="Strand",
        #                            starts.in.df.are.0based=FALSE)

#snprang40b<-makeGRangesFromDataFrame(dataSNP,
 #                                        keep.extra.columns=TRUE,
  #                                       ignore.strand=TRUE,
   #                                      seqinfo=NULL,
    #                                     seqnames.field="Chr",
     #                                    start.field="Start",
      #                                   end.field="End",
       #                                  strand.field="Strand",
        #                                 starts.in.df.are.0based=FALSE)
#start(snprang40b)<-start(snprang40b) - 40
#end(snprang40b)<-end(snprang40b) + 40

message("done df, prepare for overlapping...")

#find overlaps

### determine region with at least 3 CpG
hitbcp5<-findOverlaps(cpg_5,dmr216)
cp5_216.dmr<-data.frame(cpg_5[queryHits(hitbcp5),], dmr216[subjectHits(hitbcp5),])
write.table(cp5_216.dmr,"05_results/dataframe/CpG.5.216dmr.txt",quote=F)

# overlap clean data (3cpg, transcripts path1)
hitbcp10 <-findOverlaps(cpg_10, dmr216)
cp10_216.dmr<-data.frame(cpg_10[queryHits(hitbcp10),], dmr216[subjectHits(hitbcp10),])
write.table(cp10_216.dmr,"05_results/dataframe/CpG.10.216dmr.txt",quote=F)


# all dmr
### determine region with at least 3 CpG
hitbcp5<-findOverlaps(cpg_5,dmr)
cp5_dmr<-data.frame(cpg_5[queryHits(hitbcp5),], dmr[subjectHits(hitbcp5),])
write.table(cp5_dmr,"05_results/dataframe/CpG.5.dmr.txt",quote=F)

# overlap clean data (3cpg, transcripts path1)
hitbcp10 <-findOverlaps(cpg_10, dmr)
cp10_dmr<-data.frame(cpg_10[queryHits(hitbcp10),], dmr[subjectHits(hitbcp10),])
write.table(cp10_dmr,"05_results/dataframe/CpG.10.dmr.txt",quote=F)
