#!/bin/sh

DIR='directory/'
for FILE in $(ls "$DIR")
do
    echo $FILE
done
