#!/bin/sh

# Iterate through all files in a directory
DIR='directory/'
for FILE in $(ls "$DIR")
do
    echo $FILE
done

# Iterate through all files in a directory excluding files with a certain extension
for FILE in $(ls -p "$DIR" | grep -v .bz2)
do
    echo $FILE
done
