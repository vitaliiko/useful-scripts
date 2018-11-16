#!/usr/bin/env bash

string_length=${1:-64}
character_set=${2:-'a-zA-Z0-9-_'}
 
cat /dev/urandom | tr -dc $character_set | fold -w $string_length | head -n 1

# Result exxample: 
# AxZta_aP9JKlq3StM9WlSZ7rgyXvdSpksJF1TIyococzZMMy0B54bVKckV_ruvFD
