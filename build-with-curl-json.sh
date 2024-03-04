#!/bin/bash
##
# Script to send the BASIC file to the service using the curl to send the binary
# to the service, and retrieve a build result as structured data.
#
# This example code requires:
#
#   curl
#   jq
#   sed
#   base64
#
# The submission code examples come from here:
#
#   https://build.riscos.online/ci-build.html#curl
#
# The result comes out as JSON, which is described under the JSON API, here:
#
#   https://build.riscos.online/api.html
#
# Syntax: build-with-curl-json.sh [<input-file> [<output-prefix>]]
#

set -eo pipefail

input_file="${1:-myprogram,fd1}"
output_prefix="${2:-data}"

# Remove the result data if any
rm -f result.json

echo Run on the build service
# Note: The curl -F option treats a `,` as a separator, so RISC OS
#       filenames can't just be given directly - instead we have
#       curl read the file from stdin.
curl --silent -F source=@- -o result.json http://json.build.riscos.online/build/json < "$input_file"

if [[ ! -f result.json ]] ; then
    echo "CURL request failed (no JSON output generated)" >&2
    exit 1
fi

# Write out the messages and output, indented.
echo "Build completed:"
jq -r '.messages[]' result.json | sed 's/^/  /'
echo "Output:"
jq -r 'reduce .output[] as $i ("";. + $i)' result.json | sed 's/^/  /'

# Check that we were successful
RC=$(jq -r .rc result.json)
echo "Exit code: $RC"

FILETYPE=$(jq -r .filetype result.json)
FILETYPE_HEX=$(printf '%03x' "$FILETYPE")
if [ "$RC" = 0 ] ; then
    echo "Output type: &$FILETYPE_HEX"
    jq -r .data result.json | base64 --decode - > "${output_prefix},$FILETYPE_HEX"
fi

# Return the RC to the user, so that we can use this in scripts if we want
exit "$RC"
