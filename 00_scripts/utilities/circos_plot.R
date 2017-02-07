#!/usr/bin/Rscript#!/usr/bin/Rscript

#################################################################################
##  SPECIFY THE FOLDER TO UPLOAD AND CHOOSE PARAMETER VALUES FOR THE ANALYSIS  ##
#################################################################################
rm(list=ls())
setwd("")

########################
##  Loads R packages  ##
########################

#source("http://bioconductor.org/biocLite.R")
#  biocLite("biovizBase")
#install.packages(" reshape")   
library(ggbio)
library(GenomicRanges)
library(ChIPpeakAnno)
#library(org.Mn.eg.db)
library(org.Hs.eg.db)
library(gtools)
#library(reshape)
library(biomaRt)
library(org.Mm.eg.db)
library(biovizBase)

############################
##  Parameters for data   ##
############################

# species
Arg1 <- "Mouse"
# name of data frame to import 
Arg2 <- "/is1/users/lamfab01/Chiapet_circos/Zhang.et.al_ST2_mes_interactions.txt"  
Arg3 <- "/is1/users/lamfab01/Chiapet_circos/list_genes_tissus_spe_mESC_20140214_convert.txt"

#################
## import data ##
#################

df <- read.table(Arg2, header=TRUE, stringsAsFactors=FALSE, row.names=NULL)
spe <- read.table(Arg3, header=TRUE, stringsAsFactors=FALSE, row.names=NULL)

#######################     
## data manipulation ##
#######################

df2 <- df
df2[,1] <- as.factor(as.character(df2[,1]))
df2[,4] <- as.factor(as.character(df2[,4]))
df2 <- subset(df2, df2[,1]!= "chrM" & df2[,4] != "chrM")
## remove the level "chrM" other possibility df2[,1] <- factor(df2[,1]) ##
df2[,1] <- factor(df2[,1]) 
df2[,4] <- factor(df2[,4]) 

df_left <- df2[,c(1:3)]
df_right <- df2[,c(4:6)]

# chr.sub<-c(paste(levels(df2[,1])))
        
#####################     
## data annotation ##
#####################
ensmart <- useMart("ensembl", dataset="mmusculus_gene_ensembl")
tss <- getAnnotation(ensmart, "TSS")
			
			data(TSS.mouse.GRCm38)
			data(TSS.mouse.NCBIM37)
			
fun.anno <- function (x,j) {

		print("Load file and convert to BED")
		
		BED <- x ## should be a data.frame
        j <- j ## should be character string
        #dist <- d ## should be an integer
        
        BED$names <- paste(j, 1:nrow(x), sep="") #rep_len("chiapet", length(BED[,1]))
        BED$pets <- df2[,7] # add the score
        BED$strand <- rep_len("+", nrow(BED))
        BED <- setNames(BED, rep(" ", length(BED)))
		
		print("Convert file to RangedData")
        RD <- BED2RangedData(BED, header=FALSE)
		
		annotatedPeak <- annotatePeakInBatch(RD, ensmart,
										featureType = "TSS", 
                                        PeakLocForDistance = "middle", 
                                        FeatureLocForDistance = "TSS",
                                        output = "overlapping", 
                                        multiple=TRUE, # ne pose pas de problème car on chercher des gènes annotés
                                        select="all",
                                        maxgap= 0
                                        #AnnotationData = TSS.mouse.GRCm38
                                        )
		IDs_df <-  as.data.frame(addGeneIDs(annotatedPeak, mart=ensmart, IDs2Add=c("external_gene_id","refseq_mrna","refseq_ncrna","refseq_peptide")))	
		#IDs_df <- as.data.frame(addGeneIDs(annotatedPeak, 
		#							orgAnn = "org.Mm.eg.db", 
		#							IDs2Add = "symbol"))
		return(IDs_df)
		}
		
IDs_df_l <- fun.anno (df_left,"left")
IDs_df_r <- fun.anno (df_right,"right")
				
############
## subset ##
############
		
subgroup <- function (x) {		
		## subseting on tissue specific genes ##
		dfinput <- read.table(Arg3, header=TRUE, stringsAsFactors=FALSE, row.names=NULL)
		list <- dfinput$ensembl_gene_id
		xout <-  x[x[,8] %in% list,] # subseting could use 
		return(xout)
    }
		
findkeys <- function (l,r) {		
		key_left <- l[,6]
		key_right <- r[,6]
		key_right <- gsub("right","",key_right)
		key_left <- gsub("left","",key_left)
		keys <-  1:nrow(df2) %in% c(key_left,key_right) # subseting could use 
		return(df2[keys,])
		}

## selecting for annotation corresponding to tissue specific 
## genes and with link found within genes

#find.within.annotation <- function (l,r,k) {		
#		l <- subset(l, l[,11] == k)
#		r <- subset(r, r[,11] == k)
#		key_left <- l[,6]
#		key_right <- r[,6]
#		key_right <- gsub("right","",key_right)
#		key_left <- gsub("left","",key_left)
#		keys <-  1:nrow(df2) %in% c(key_left,key_right) # subseting could use 
#		df3 <<- df2[keys,]
#
#		}

		
#####################
## what job to do? ##
#####################
		
IDs_df_lspe2 <- subgroup (IDs_df_l)
		#IDs_df_l2 <- subset(IDs_df_l2, distancetoFeature >= -100 & distancetoFeature <= 20)
		#IDs_df_l2 <- subset(IDs_df_l2, abs(distancetoFeature) <= 100 )
		
IDs_df_rspe2 <- subgroup (IDs_df_r)
		#IDs_df_r2 <- subset(IDs_df_r2, distancetoFeature >= -100 & distancetoFeature <= 20)
		#IDs_df_r2 <- subset(IDs_df_r2, abs(distancetoFeature) <= 100 )
		
		df3 <- findkeys(IDs_df_l2,IDs_df_r2)
		nrow(df3)
		
		#library(plyr) 
		#uniq_t <- (IDs_df_l2)
		#uniq_t <- ddply(uniq_t, .(peak), head, n = 1)
		#nrow(uniq_t)
		
		#find.within.annotation(IDs_df_l2,IDs_df_r2,"upstream")
		#nrow(df3)
		#df3up <- df3
		#find.within.annotation(IDs_df_l2,IDs_df_r2,"overlapStart")
		# nrow(df3)
		#df3tss <- df3 
		#find.within.annotation(IDs_df_l2,IDs_df_r2,"inside")
		#nrow(df3)
		#find.within.annotation(IDs_df_l2,IDs_df_r2,"overlapEnd")
		#nrow(df3)
		#find.within.annotation(IDs_df_l2,IDs_df_r2,"downstream")
		#nrow(df3)
		
		
########################################      
## circos interaction annotated genes ##
########################################

## subset_chr
#chr.sub<-c(paste(levels(IDs_df2[,1]))) #
chr.sub <- paste("chr", 1:19, sep = "")
chr.sub  <- c(chr.sub, "chrX", "chrY")

## levels tweak
df3[,1] <- as.factor(as.character(df3[,1]))
df3[,4] <- as.factor(as.character(df3[,4]))
require(gtools); chr.sub.sorted <- mixedsort(chr.sub)
levels(df3[,1]) <- c(chr.sub.sorted)
levels(df3[,4]) <- c(chr.sub.sorted)
df3$strand <- rep_len("*", nrow(df3))     

df3 <- df3[order(df3[,1],df3[,2]),]

gr1<- with(df3, GRanges(chrom_left, IRanges(start_left, end_left),strand=strand))
gr2<- with(df3, GRanges(chrom_right, IRanges(start_right, end_right),strand=strand))
     		
     		
## add extra column
#nms <- colnames(df3)
#.extra.nms <- setdiff(nms, c("chrom_left", "chrom_right", "start_left", "start_right"))
#values(gr1) <- df3[, .extra.nms]

## remove out-of-limits data
mm9Ideogram <- getIdeogram("mm9", cytoband = FALSE)
mm9Ideo <- mm9Ideogram
mm9Ideo <- keepSeqlevels(mm9Ideogram, chr.sub.sorted)

seqs <- as.character(seqnames(gr1))
.mx <- seqlengths(mm9Ideogram)[seqs]
idx1 <- start(gr1) > .mx
seqs <- as.character(seqnames(gr2))
.mx <- seqlengths(mm9Ideogram)[seqs]
idx2 <- start(gr2) > .mx
idx <- !idx1 & !idx2
gr1 <- gr1[idx]
seqlengths(gr1) <- seqlengths(mm9Ideo)
gr2 <- gr2[idx]
seqlengths(gr2) <- seqlengths(mm9Ideo)

values(gr1)$to.gr <- gr2
gr <- gr1

##################
##  Circos plot  #
##################

p <- ggplot() + layout_circle(mm9Ideo, geom = "ideo", aes(fill = factor(seqnames)), radius = 30, trackWidth = 2)
p <- p + layout_circle(mm9Ideo, geom = "scale", size = 2, radius = 32, trackWidth = 2)
p <- p + layout_circle(mm9Ideo, geom = "text", aes(label = seqnames), vjust = 0, radius = 35, trackWidth = 7)
p <- p + layout_circle(gr, geom = "link", linked.to = "to.gr", aes(color = seqnames, alpha = 0.1), radius = 29, trackWidth = 1)

pdf("circos_ESCspecific_500bp_inside-genes_interactions.pdf")
p
dev.off()
