#!/bin/sh

# Iterate through all files in a directory
DIR='spending-tracker'
for FILE in $(find "$DIR" | grep \\.java)
do
    echo $FILE
    sed -i $'s/\r$//' $FILE
done
