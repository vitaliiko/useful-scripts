#!/bin/bash

DIR=$1
filter=${2:-.flac}

cd $DIR

while IFS= read -r file; do
  echo
  echo Start to convert $file

  file_name=$(echo $file | awk -F. '{print $1}')
  ffmpeg -loglevel error -i $file -ab 320k -map_metadata 0 -id3v2_version 3 $file_name.mp3

  echo $file_name.pm3 is ready
  sleep 20
done <<< $(ls | grep $filter)
