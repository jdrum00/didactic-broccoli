#!/bin/sh

POPFILE=/projects/spe1/tiger-beetles/data/metadata/popfiles/Dromo.populations
# WIDTH=${1:-1200}

ls -d results-* | while read DIR; do
  IN=`echo $DIR | cut -d '-' -f 2-`; echo $DIR
  NUMLOCI=`sed -n '3p' data/$IN.str* | wc -w`; NUMLOCI=$((NUMLOCI-6)); echo "Loci: $NUMLOCI"
  NUMINDS=`cut -f 1 data/$IN.str* | sed '1d' | wc -l`; NUMINDS=$((NUMINDS/2)); echo "Individuals: $NUMINDS"
  NUMPOPS=`cut -f 2 data/$IN.str* | sed '1d' | sort -u | wc -l`; echo "Populations: $NUMPOPS"
  (cd $DIR; mkdir -p plot-data; mkdir -p ps; cp /projects/spe1/software/distruct1.1/drawparams .; patch drawparams ~/software/distruct1.1/drawparams.patch; echo "Generating popq and indivq files."; 
  for INFILE in *_f; do BIT=`echo $INFILE | cut -d '_' -f 2,3`; sed -n '/Inferred Clusters/,/---------/p' $INFILE | sed '1,3d' | grep -v '\------------' > plot-data/$BIT.popq; sed -n '/Inferred clusters/,/^$/p' $INFILE | sed '1d' > plot-data/$BIT.indivq; done
  cut -f 2 $POPFILE | sort -u | awk '{OFS="\t"} {print $1, $1}' | sed 's/Loc0*//' > locations.labels
  cut -f 2,3 $POPFILE | sort -u | awk '{OFS="\t"} {print $1, $2}' | sed 's/Loc0*//' | sort -k2,2 -k1,1n > species.labels
  cut -f 1 species.labels | while read POPID; do grep -w "^$POPID" locations.labels; done > tmp; mv tmp locations.labels
  for K in 1 2 3 4 5 6 7; do echo -n "$K "; for REP in {01..10}; do
    if [ -e plot-data/K${K}_rep$REP.popq ]; then
      echo -n "$REP "
      INPS=K${K}_rep$REP.ps; OUTPS=K${K}_rep$REP.c.ps; PNG=K${K}_rep$REP.png; PNGZERO=K${K}_rep${REP}-0.png
      distruct -a locations.labels -b species.labels -M $NUMPOPS -N $NUMINDS -K $K -p plot-data/K${K}_rep$REP.popq -i plot-data/K${K}_rep$REP.indivq -o ps/$INPS
      # This gets it moved to the upper left.
      gs -o ps/$OUTPS -sDEVICE=pngalpha -c "0 450 translate" -f ps/$INPS
      # And this (semi-manually) crops it properly.
      FIRSTBIT=`echo $IN | cut -d '-' -f 1-2`
      if [ "$FIRSTBIT" == "tree-top" ]; then WIDTH=1200; else WIDTH=300; fi
      convert -density 300x300 -crop ${WIDTH}x300 ps/$OUTPS ps/K${K}_rep$REP.png; mv ps/K${K}_rep$REP-0.png K${K}_rep$REP.png; rm ps/K${K}_rep$REP-*.png
    fi
  done; echo; done)
done
