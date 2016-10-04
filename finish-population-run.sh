#!/usr/bin/bash

echo "Tidying links and outputs."
find . -type l -name {0,1,2,3,4,5}\*.tsv.gz -exec rm {} \;
mkdir tsv-spam
mv *{fst,phistats}_*.tsv tsv-spam/
mv tsv-spam/*fst_sum* .
ls
echo "Zipping large output files."
gzip batch_1.populations.log batch_1.vcf
ls -lh *.gz
echo "Running Phylip."
cp batch_1.phylip.fixed infile
rm outfile outtree
~/software/phylip-3.696/exe/dnadist < <(echo Y)
mv outfile infile
~/software/phylip-3.696/exe/fitch < <(echo -e "G\nY")
echo "Tweaking tree output."
sed -n '1,/^remember/p' outfile > tree.txt
LOCFILE=~/data/metadata/locations.txt
POPFILE=~/data/metadata/popfiles/Dromo.populations
cut -f 1,2 $LOCFILE | while read LOCNUM LOCNAME; do SPECIES=`grep $LOCNUM $POPFILE | head -n 1 | cut -f 3`; sed -i "s/$LOCNUM/$LOCNUM $SPECIES ZZZ $LOCNAME/" tree.txt; done
awk '{spstr=""; num=100-length($0); for(c=0;c<num;c++) spstr=spstr" "; sub(/ZZZ/, spstr, $0); print $0}' tree.txt > tmp; mv tmp tree.txt


# Possible improvement:
# cut -f 1,2 $LOCFILE | while read LOCNUM LOCNAME; do
#     SPECIES=`grep $LOCNUM $POPFILE | head -n 1 | cut -f 3`;
#     N=`grep -c $LOCNUM $POPFILE`;
#     sed -i "s/$LOCNUM/$LOCNUM $LOCNAME ZZZ $SPECIES N=$N/" tree.txt; done
