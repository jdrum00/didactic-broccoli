POPFILE=~/data/metadata/popfiles/Dromo.populations

COLS=`head -n 3 batch_1.structure.tsv | tail -n 1 | wc -w`
ROWS=`cat batch_1.structure.tsv | wc -l`
cut -f 1-$((COLS-1)) batch_1.structure.tsv > batch_1.structure.tsv.stru
cut -f 1 batch_1.structure.tsv.stru | sed '1,2d' | sort -u | while read ID; do SPC=`grep "$ID" $POPFILE | cut -f 3`; sed -i "s|^$ID|$ID\t$SPC|g" batch_1.structure.tsv.stru; done

# Prepare to paste in the number of rows and columns once you're in R.
echo "Rows:  $(((ROWS-2)/2))   Cols:  $((COLS-2))"

R --slave --args $(((ROWS-2)/2)) $((COLS-2)) < ~/scripts/plot-pca.R
