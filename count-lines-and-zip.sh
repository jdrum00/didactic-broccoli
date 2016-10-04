#!/bin/sh

STARTPAT=$1

if [ "$STARTPAT" == "" ]; then
  echo "Need to enter a starting pattern."; exit 1
fi

for F in $STARTPAT*.fq; do
  wc -l $F >> $STARTPAT.linecounts.txt
  gzip $F
done

