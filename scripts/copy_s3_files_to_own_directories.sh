#!/bin/sh

base_path=$1
files=$(aws s3 ls s3://${base_path}/ | awk '{print $4}')

for FILE in $files
do
  dir_name=$(echo $FILE | sed s/".csv"//g)
  aws s3 cp s3://$base_path/$FILE s3://$base_path/$dir_name/$FILE
done

# This script will copy all files to dirs with those file names

# Example:

# If folder contains the following files
# file1.txt
# file2.txt

# the result would be
# file1/file1.txt
# file2/file2.txt


# Usage: ./copy_s3_files_to_own_directories.sh bucket/folder
