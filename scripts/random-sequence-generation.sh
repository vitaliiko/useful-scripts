#!/usr/bin/env bash

cat /dev/urandom | tr -dc 'a-zA-Z0-9-_' | fold -w 64 | head -n 1
