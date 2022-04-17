#!/bin/sh

file=$1

while grep -q UUID $file
do
uuid=$(uuidgen)
sed -i "0,/UUID/ s/UUID/${uuid}/" $file
done
