#!/bin/sh

# Run from inside the top pX-rY directory.
STR=$1  # data file
K=$2
REP=$3
MEM=${4:-12}

IN=`basename $STR | sed 's/.str$//'`
INDS=$((`cat $STR | sed '1d' | wc -l`/2)); NUMCOLS=`sed -n '3p' $STR | wc -w`; NUMLOCI=$((NUMCOLS-3))
mkdir -p results-$IN/logs
J=struct-$IN-k$K-rep$REP; LOG=results-$IN/logs/$J.log
TMPSCRIPT=`mktemp`
RAND=`~/scripts/rand.sh`
(echo '#!/bin/sh'; echo "structure -i data/$IN.str -N $INDS -L $NUMLOCI -D $RAND -K $K -o results-$IN/${IN}_K${K}_rep$REP >> $LOG") > $TMPSCRIPT
sbatch -n 1 -c 1 -J $J -o $LOG -e $LOG --mem-per-cpu=${MEM}000m -t 24:00:00 $TMPSCRIPT
rm $TMPSCRIPT
