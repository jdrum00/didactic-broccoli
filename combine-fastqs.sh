#!/bin/sh

if [ "$1" == "" ]; then
    echo "Enter a number or other leading pattern so the script doesn't tackle everything at once."; exit 1
fi

ls $1*.*.fq.gz | cut -c 1-3 | sort -u | while read SAMPLE; do NUM=`ls ${SAMPLE}*.*.fq.gz | wc -l`; echo "Combining $NUM files for sample $SAMPLE."; zcat ${SAMPLE}*.*.fq.gz | gzip -c - > $SAMPLE.fq.gz; rm $SAMPLE*.*.fq.gz; done

# ls *{a,b}.*.fq.gz | cut -c 1-3 | sort -u | while read SAMPLE; do ls ${SAMPLE}{a,b}.*.fq.gz; zcat ${SAMPLE}{a,b}.*.fq.gz | gzip -c - > $SAMPLE.fq.gz; done
