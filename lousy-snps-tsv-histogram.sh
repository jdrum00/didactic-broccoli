F=$1
echo -e "$F\t`zcat $F | awk '{if($6<-100) print $0}' | wc -l`\t`zcat $F | awk '{if($6>-100 && $6 <= -10) print $0}' | wc -l`\t`zcat $F | awk '{if($6>-10 && $6 <= -1) print $0}' | wc -l`\t`zcat $F | awk '{if($6>-1 && $6 <= 0) print $0}' | wc -l`\t`zcat $F | awk '{if($6>0 && $6 <= 1) print $0}' | wc -l`" | sed 's/.snps.tsv.gz//'

