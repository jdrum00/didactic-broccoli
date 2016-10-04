library(ggplot2)

args <- commandArgs(TRUE)

indat <- read.table(args[1])
outname = paste(args[1],"png",sep=".");

xaxislabeltext = args[2]

png(file=outname, width=1000, height=400);

# This one works:
# hist(as.numeric(indat[,1]), xlim=c(0, 1), breaks=50, xlab=xaxislabeltext, ylab="Occurrences", col="red", main="")

# ggplot(indat, aes(x=xaxislabeltext)) + geom_histogram(binwidth=0.01)

outname = paste(args[1],"gg.png",sep=".");
png(file=outname, width=1000, height=400);
# ggplot(indat, aes(x=xaxislabeltext)) + geom_density()

ggplot(as.numeric(indat[,1]), aes(x=xaxislabeltext)) +
    geom_histogram(aes(y=..density..),      # Histogram with density instead of count on y-axis
                   binwidth=.5,
                   colour="black", fill="white") +
    geom_density(alpha=.2, fill="#FF6666")  # Overlay with transparent density plot



