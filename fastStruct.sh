#!/bin/sh

IN=$1
K=$2
SET=$3

if [ "$SET" == "1" ]; then
    for REP in 01 02 03 04 05; do OUTDIR=results-$IN/rep$REP; mkdir -p $OUTDIR; python ~/software/fastStructure/structure.py -K $K --input=data/$IN --output=$OUTDIR/${IN} --format=str --full; done
else
    for REP in 06 07 08 09 10; do OUTDIR=results-$IN/rep$REP; mkdir -p $OUTDIR; python ~/software/fastStructure/structure.py -K $K --input=data/$IN --output=$OUTDIR/${IN} --format=str --full; done
fi
