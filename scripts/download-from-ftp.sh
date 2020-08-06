#!/bin/sh

username=$1
password=$2
base_path=$3
target_file_name=$4
unzip_folder=$5

file_name_without_extension=$(echo $target_file_name | awk -F. '{print $1}')
unzip_result_folder=${unzip_folder}/${file_name_without_extension}_$(date '+%H_%M')

mkdir $unzip_result_folder
echo wget --user=$username --password=$password $base_path/$target_file_name
wget --user=$username --password=$password $base_path/$target_file_name
unzip $target_file_name -d $unzip_result_folder

