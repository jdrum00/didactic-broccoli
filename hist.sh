INFILE=$1
COL=${2:-1}
NAME=${3:-hist}

if [ "$INFILE" == "" ]; then INFILE="-"; fi

sed '1d' $INFILE | cut -f $COL > $NAME.dist; R --slave --args $NAME.dist $NAME < ~/scripts/hist.R

