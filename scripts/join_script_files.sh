#!/bin/bash
output="all_scripts.md"
rm -f "$output"

for file in *.sh; do
  echo "$file" >> "$output"
  echo '```' >> "$output"
  cat "$file" >> "$output"
  echo '```' >> "$output"
  echo "_______" >> "$output"
  echo >> "$output"
done
