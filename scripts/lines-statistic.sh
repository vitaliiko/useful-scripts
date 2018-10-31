#!/usr/bin/env bash

file_name=$1

# Example of input file:
#
# WARNING: (array-type) /tables.service.ts[68, 16]: Array type using 'T[]' is forbidden for non-simple types. Use 'Array<T>' instead.
# WARNING: (array-type) /reservations.service.ts[69, 63]: Array type using 'T[]' is forbidden for non-simple types. Use 'Array<T>' instead.
# WARNING: (prefer-template) /activities.service.ts[71, 32]: Use a template literal instead of concatenating with a string literal.
# WARNING: (array-type) /tables.service.ts[17, 47]: Array type using 'T[]' is forbidden for non-simple types. Use 'Array<T>' instead.
# WARNING: (no-untyped-signature) /tables.component.ts[113, 3]: All arguments of method must have types.
# WARNING: (array-type) /tables.service.ts[32, 26]: Array type using 'T[]' is forbidden for non-simple types. Use 'Array<T>' instead.
# WARNING: (no-untyped-signature) /tables.component.ts[121, 3]: All arguments of method must have types.

awk -F'[()]' '{print $2}' $file_name `# get text inside round brackets` \
    | grep -v -e '^$' `# remove empty lines` \
    | sort | uniq -c `# count occurrences of each unique line` \
    | sort -r -g >> ${reportFile}

# Output:
# 
# 4 array-type
# 2 no-untyped-signature
# 1 prefer-template
