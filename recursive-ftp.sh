#!/bin/bash

ftp_site=www.jennformatics.net
username=jennform
passwd=Att,1613

remote=/public_html

folder=$1
remfolder=${2:-$1}

cd $folder
pwd

ftp -in <<EOF
open $ftp_site
user $username $passwd
mkdir $remote/$remfolder/$folder
cd $remote/$remfolder/$folder
mput *
close
bye
EOF
