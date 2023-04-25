#!/bin/bash

# Check if exactly two arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 string1 string2"
  exit 1
fi

# Assign the input strings to variables
string1="$1"
string2="$2"

# Use echo to pass the input strings to awk via a pipeline
merged_output=$(echo -e "$string1\n$string2" | awk '
/^$/{
  next
}
/^\[.*\]$/{
  hdr = $0
  next
}
a[hdr] != "" {
  if (a[hdr] !~ "(^|[[:space:]])" $0 "([[:space:]]|$)") {
    a[hdr] = a[hdr] ORS $0
  }
  next
}
{
  a[hdr] = $0
  seq[++n] = hdr
}
END {
  for (i=1; i<=n; i++)
    print seq[i] ORS a[seq[i]] (i<n ? ORS : "")
}')

# Print the merged output
echo "$merged_output"
