#!/bin/sh

input_file=$1

while IFS= read -r LINE;
do
  echo "$LINE" | md5sum | base64
done < "$input_file"
