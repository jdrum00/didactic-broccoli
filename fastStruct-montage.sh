#!/bin/sh

SEGMENT=`pwd -P | cut -d '/' -f 6 | sed 's/results-//' | sed 's|/|; |'`
TITLE="P=2, r=0.75; $SEGMENT"
FILENAME=`echo $TITLE | sed 's/, /-/' | tr ' ' '-' | sed 's/P=/p=/g' | sed 's/[ =0.;]//g'`.png
montage -title "$TITLE" -label '%f' -pointsize 14 -tile 1x -geometry 400x280 *.png ../$FILENAME
