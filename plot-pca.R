library("adegenet")

args <- commandArgs(TRUE)
numrows <- as.numeric(args[1])
numcols <- as.numeric(args[2])

obj <- read.structure('batch_1.structure.tsv.stru', n.ind=numrows, n.loc=numcols, onerowperind=FALSE, col.lab=1, col.pop=2, row.marknames=2, ask=FALSE)
X <- scaleGen(obj, NA.method="mean")
pca1 <- dudi.pca(X,cent=FALSE,scale=FALSE,scannf=FALSE,nf=3)

png('pca.png')
col <- c("green", "gold", "black", "red", "purple", "blue", "grey", "cyan")
s.class(pca1$li, pop(obj), xax=1, yax=2, col=col, label=NULL, axesell=FALSE, cstar=0, cpoint=1, cellipse=3)
dev.off()
