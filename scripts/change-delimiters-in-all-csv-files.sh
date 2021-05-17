#!/bin/sh

workdir=$1

cd $workdir
mkdir -p updated

for FILE in $(ls)
do
  echo Handle $FILE
  file_name=$(echo $FILE | sed s/".csv"//g)
  csvformat -D '|' $FILE > updated/$file_name.dat
done

