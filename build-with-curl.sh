#!/bin/bash
##
# Script to send the BASIC file to the service using the curl to send the binary
# to the service, and retrieve a build result.
#
# This example code requires:
#
#   curl
#   sed
#
# The submission code examples come from here:
#
#   https://build.riscos.online/ci-build.html#curl
#
# Syntax: build-with-curl.sh [<input-file> [<output-file>]]
#

set -eo pipefail

input_file="${1:-myprogram,fd1}"
output_file="${2:-data,ffd}"

# Remove the failure content
rm -f "${output_file}" failed.log

echo Run on the build service
# Note: The curl -F option treats a `,` as a separator, so RISC OS
#       filenames can't just be given directly - instead we have
#       curl read the file from stdin.
STATUS_CODE=$(curl --silent -F source=@- -o "${output_file}" --write-out "%{http_code}" http://json.build.riscos.online/build/binary < "$input_file")

if [[ "$STATUS_CODE" == 200 ]] ; then
    echo Success - wrote
else
    echo Failed:
    mv "${output_file}" failed.log
    sed 's/^/  /' failed.log
    exit 1
fi
