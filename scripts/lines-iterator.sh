#!/bin/bash

while IFS=$'\t' read -r column1 column2 column3; do
  echo "$column2"
done < input.txt > output.txt
