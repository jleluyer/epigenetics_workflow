#!/usr/bin/Rscript

library(vegan)
library(reshape2)
library(dplyr)
library(ape)
library(cluster)

#mergedf<-read.table("05_results/dataframe/data.frame.tile1000bp.percent.3cpg.tsv",header=T,dec=".")
#save(mergedf,file="data_RDA.Rda")


#message("upload completed")

load("data_RDA.Rda")

#PCoA
factor<-as.data.frame(mergedf[,2:4])
factor.nosex<-as.data.frame(mergedf[,3:4])
responVar<-as.matrix(mergedf[,6:ncol(mergedf)])
euc_responVar=daisy(responVar, metric="euclidean")
Geno_pcoa=pcoa(euc_responVar)
save(Geno_pcoa,file="genopcoa.Rda")
stop("PCoA completed, now check number pcoa to retain")


Geno_pcoa$values
Geno_rda=Geno_pcoa$vectors[,1:6]


### Complete RDA with PCA factors #######
#########################################

rda1=rda(Geno_rda~.,factor, scale=T)
RsquareAdj(rda1)
# Tester par permutations si le modele est globalement significatif
anova(rda1, step=1000)
# Test par permutations sur chaque variable explicative (tests marginaux)
anova(rda1,by="margin",step=1000)


# redo rda whitout sex effect
rda1=rda(Geno_rda~.,factor.nosex, scale=T)
RsquareAdj(rda1)

###### Partial RDA ###########
##############################
### Replace by numeric values
factor.nosex$enviro <- ifelse(factor.nosex$enviro=="cap", 0, 1)
factor.nosex$geno <- ifelse(factor.nosex$geno=="hat", 0, 1)

### Do a partial RDA by ocntrolling for factor$treatment
rda_partial=rda(Geno_rda,factor.nosex$enviro,factor.nosex$geno)
set.seed(10);anova(rda_partial, step=1000)
RsquareAdj(rda_partial)

### Do a partial RDA by controlling for factor$V1
rda_partial=rda(Geno_rda,factor.nosex$geno,factor.nosex$enviro)
set.seed(10);anova(rda_partial, step=1000)
RsquareAdj(rda_partial)


# GRAPHIQUES DE LA RDA;
# -------------------;
sommaire = summary(rda1)

# GRAPHIQUE RDA1*RDA2;
# -------------------;
axes=c(1,2);
R2 = c("8.4%","7.6%")
marqueur = sommaire$species[,axes]
envt = sommaire$biplot[,axes]
objet = sommaire$site[,axes]

#calcule la qualite graphique des especes (representativite)
qualite12 = marqueur[,1]^2 + marqueur[,2]^2
marqueur2 = marqueur[qualite12>0.05,]

#graphe des axes et des marqueurs 
par(new=F)
yrange1 = round(max(c(abs(marqueur[,2]),abs(objet[,2]))),digits=2)
xrange1 = round(max(c(abs(marqueur[,1]),abs(objet[,1]))),digits=2)
plot(marqueur2,type="p",xlab=paste("RDA",axes[1]," (",R2[1],")",sep=""),
     ylab=paste("RDA",axes[2]," (",R2[2],")",sep=""),ylim=c(-yrange1,yrange1),
     xlim=c(-xrange1,xrange1),pch="+",cex=0)
abline(h=0,lty=3)	# cross-lines
abline(v=0,lty=3)
#points(objet,pch=c(rep(21,20),rep(22,19)), col=c(rep("black",10),rep("grey65",9),rep("black",10),rep("grey65",10)), bg=c(rep("black",10),rep("grey65",9),rep("black",10),rep("grey65",10)))

points(objet,pch=c(rep(21,20),rep(24,19)), col=c(rep("red",10),rep("blue",10),rep("red",9),rep("blue",10)), bg=c(rep("red",10),rep("blue",10),rep("red",9),rep("blue",10)))

#graphe des variables explicati
#graphe des variables explicatives 
#a) points;
par(new=T)
yrange2 = round(max(abs(envt[,2])),digits=2)
plot(envt,type="n",axes=F,ylab="",xlab="",ylim=c(-yrange2,yrange2),xlim=c(-1,1),pch=0,cex=0.75)
axis(4, col="black",col.ticks="black",col.axis="black"); axis(3,col="black",col.ticks="black",col.axis="black")

#b) fleches;
x1 <- envt[,1]*0.95;
y1 <- envt[,2]*0.95;
points(x1,y1,pch="");
arrows(x0=rep(0,12),y0=rep(0,12),x1=x1, y1=y1,length=0.05, col="black")

#c) Identification des facteurs;
text(envt[1,1],envt[1,2],"River **", cex=1,pos=3,font=2)
text(envt[2,1],envt[2,2],"Treatment **", cex=1,pos=4,font=2)

#ajouter p-value et R2
R=expression(paste("adj.R"^"2"))
text(-1,0.95,R,pos=4)
text(-0.82,0.95,"= 0.23",pos=4)
text(-1,0.85,"P-value < 0.001",pos=4)

#legend
legend("topright",inset=0.02,legend=c("Capilano river", "Quinsam river", "Hatchery", "Wild"), pch=c(21,24,15,15), col=c('black','black','red','blue'),bty="n")

dev.print(pdf, file="../05_results/figures/rda.pdf")

