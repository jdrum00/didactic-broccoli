#!/bin/sh

PARMS=`pwd -P | cut -d '/' -f 5 | sed 's/results-//' | sed 's|/|; |'`;
P=`echo $PARMS | cut -d '-' -f 1 | sed 's/p//'`; R=`echo $PARMS | cut -d '-' -f 2 | sed 's/r//'`;
for DIR in `ls -d results-*`; do IN=`echo $DIR | cut -d '-' -f 2-`;
	echo $IN;
	HTMLOUTFILE="p$P-r$R-$IN-grid.html"
	echo "<h2 style=\"padding: 10px; background: #DDDDDD; width: 100%\">STRUCTURE, $PARMS, $IN</h2>" > $HTMLOUTFILE;
	for K in 1 2 3 4 5 6 7; do
		FILESTUB="p$P-r$R-$IN-K$K";
		montage -tile 1x -geometry 200 results-$IN/K${K}_rep*.png results-$IN/$FILESTUB.html;
		(cd results-$IN; grep 'img' $FILESTUB.html | sed 's/img/img style="display: inline; vertical-align: top"/'; cat ../${FILESTUB}_map.shtml; echo) >> $HTMLOUTFILE;
		rm ${FILESTUB}_map.shtml;
	done;

        FILESTUB="p$P-r$R-$IN-firstreps"
        montage -tile x1 -geometry x300 results-$IN/K*_rep01.png results-$IN/$FILESTUB.png
done
