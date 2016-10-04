#!/bin/sh

IN=$1
K=$2
REP=$3

OUTDIR=results-$IN/rep$REP
mkdir -p $OUTDIR
python ~/software/fastStructure/structure.py -K $K --input=data/$IN --output=$OUTDIR/${IN} --format=str --full
