#!/bin/sh

echo $(sed --expression 's/\([A-Z]\)/-\L\1/g' --expression 's/^-//' <<< "AppNewDomainInstructionsDrawer")