#!/usr/bin/env bash

# Usage: ./random-sequence-generator.sh 16 a-zA-Z0-9-_

string_length=${1:-64}
character_set=${2:-'a-zA-Z0-9-_'}
 
cat /dev/urandom | tr -dc $character_set | fold -w $string_length | head -n 10

# Result example: 
# AxZta_aP9JKlq3StM9WlSZ7rgyXvdSpksJF1TIyococzZMMy0B54bVKckV_ruvFD
