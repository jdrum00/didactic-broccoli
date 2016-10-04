#!/bin/sh

sed -n '2~2p' $IN.str | awk '{OFS="-"} {print $3, $2}' > results-$IN/$IN.labels
for K in 1 2 3 4 5 6 7; do python ~/software/fastStructure/distruct.py -K $K --input=results-$IN/$IN --output=results-$IN/$IN.$K.svg --popfile=results-$IN/$IN.labels; done
