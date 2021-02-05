#!/bin/sh

workdir=$1
s3_path=$2

cd $workdir

for FILE in $(ls)
do
  dir_name=$(echo $FILE | sed s/".csv"//g)
  aws s3 cp $FILE s3://$s3_path/$dir_name/$FILE
done
