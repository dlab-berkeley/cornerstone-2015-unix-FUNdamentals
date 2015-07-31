#!/bin/bash

echo "Challenge 1"

if [ `../my_files/script.R`=`R --silent -e "table(read.table('../data/animals.txt'))" ` ] ; then
	echo ...passed
else
	echo ...failed
fi

echo "Challenge 2"

if [ `longest.sh ../data/articles TXT` -eq `wc -l ../data/downloads/*.TXT| sort -n | head -1` ] ; then
	echo ...passed
else
	echo ...failed
fi
