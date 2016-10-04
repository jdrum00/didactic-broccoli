#!/bin/sh

for STR in $@; do
    IN=`basename $STR | sed 's/.str$//'`
    INDS=$((`cat $STR | sed '1d' | wc -l`/2)); NUMCOLS=`sed -n '3p' $STR | wc -w`; NUMLOCI=$((NUMCOLS-3))
    mkdir -p results-$IN/logs
    for REP in {01..10}; do
        for K in {1..7}; do
            ~/scripts/single-structure-rep.sh $STR $K $REP
	done
    done
done
