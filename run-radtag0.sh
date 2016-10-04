#!/bin/sh

FILE1=$1
FILE2=$2

UFILE1=`echo $FILE1 | sed 's/.fq.gz/.fq/'`
UFILE2=`echo $FILE2 | sed 's/.fq.gz/.fq/'`

BARCODES=~jenn/data/metadata/barcodes.txt

if [ ! -e $UFILE1 ]; then
    echo "`date` Unzipping $FILE1."
    zcat $FILE1 > $UFILE1
fi

if [ ! -e $UFILE2 ]; then
    echo "`date` Unzipping $FILE2."
    zcat $FILE2 > $UFILE2
fi

python ~jenn/software/radtag0_trimmer.py --individuals -r 70 -p $UFILE2 $BARCODES $UFILE1
