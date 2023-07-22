## plink_pedplot.R for KING pedigree plot, by Wei-Min Chen and Zhennan Zhu
rm(list=ls(all=TRUE))
library(kinship2)
ped <- read.table(file="plinksplitped.txt", stringsAsFactors=FALSE)[,3:9]
postscript("plink_pedplot.ps", paper="letter", horizontal=T)
ped$V8[ped$V8==-9 | ped$V8==0 | ped$V8==1] <- 0
ped$V8[ped$V8==2] <- 1
pedAll <- pedigree(id = ped$V4, dadid = ped$V5, momid = ped$V6, sex = as.numeric(ped$V7), affected = as.numeric(ped$V8), status = as.numeric(ped$V9), famid = ped$V3, missid = 0)
for(f in unique(ped$V3))
  if(any(ped$V5[ped$V3 == f] != 0 | ped$V6[ped$V3 == f] != 0)){
    max.num <- max(align.pedigree(pedAll[toString(f)])$n)
    size <- ifelse(max.num > 15, 42/max.num, 2.8)
    plot(pedAll[toString(f)], cex=0.5, symbolsize = size)}
dev.off()
rm(list=ls(all=TRUE))
