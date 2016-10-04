#!/bin/sh

OUTFILE=${2:-barcode-reheadered-counts.txt}
FIRSTFILE=${1:-r1.reheadered.fq.gz}
SECONDFILE=`echo $FIRSTFILE | sed 's/1/2/'`

echo -e "File\tLines\tReads\tBCsLeft\tBCsRight"
echo -ne "$FIRSTFILE\t"
echo -ne ".\t" # echo -ne "`zcat $FIRSTFILE | wc -l`\t"
echo -ne ".\t" # echo -ne "`zcat $FIRSTFILE | grep -c '^@'`\t"
echo -ne "`zcat $FIRSTFILE | grep -cf ~jenn/scripts/left.txt`\t"
echo -e "`zcat $FIRSTFILE | grep -cf ~jenn/scripts/right.txt`"

echo -ne "$SECONDFILE\t"
echo -ne ".\t" # echo -ne "`zcat $SECONDFILE | wc -l`\t"
echo -ne ".\t" # echo -ne "`zcat $SECONDFILE | grep -c '^@'`\t"
echo -ne "`zcat $SECONDFILE | grep -cf ~jenn/scripts/left.txt`\t"
echo -e "`zcat $SECONDFILE | grep -cf ~jenn/scripts/right.txt`"

exit 0
