DATE=${1:-01/01/16}
sacct -S $DATE -o CPUTime | cut -c 3- | awk '{FS=":"; OFS="\t"; h+=$1; m+=$2; s+=$3} END {print h+(m/60)+(s/3600)}'

