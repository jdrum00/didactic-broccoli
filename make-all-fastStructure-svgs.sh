#!/bin/sh

ls -d results* | while read DIR; do
    IN=`echo $DIR | cut -d '-' -f 2-`; sed -n '2~2p' data/$IN.str | awk '{OFS="-"} {print $3, $2}' > results-$IN/$IN.labels;
    PARMS=`pwd -P | cut -d '/' -f 5 | sed 's/results-//' | sed 's|/|; |'`;
    P=`echo $PARMS | cut -d '-' -f 1 | sed 's/p//'`; R=`echo $PARMS | cut -d '-' -f 2 | sed 's/r//'`;
    HTMLOUTFILE=p$P-r$R-$IN.html;
    for REPDIR in results-$IN/rep*; do
        echo $REPDIR; for K in 1 2 3 4 5 6 7; do
            REP=`basename $REPDIR | sed 's/rep/rep /'`;
            echo -n "$K ";
            python ~/software/fastStructure/distruct.py -K $K --input=$REPDIR/$IN --output=$REPDIR/$IN.$K.svg --popfile=results-$IN/$IN.labels --title="p=$P, R=0.$R; $IN; K=$K, $REP";
        done;
        # FILESTUB=`echo "p$P-r$R-$IN-$REP" | sed 's/ //'`;
        # montage -tile 1x -geometry 200 $REPDIR/*.svg $REPDIR/$FILESTUB.html;
        # mv ${FILESTUB}_map.shtml $REPDIR;  # No idea why this gets put in a different place than the HTML, but it does.
        # (cd $REPDIR; grep 'img' $FILESTUB.html | sed 's/img/img style="display=inline"/'; cat ${FILESTUB}_map.shtml; echo) >> $HTMLOUTFILE;
        echo;
    done;
done
