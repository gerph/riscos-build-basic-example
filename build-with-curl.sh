#!/bin/bash
##
# Script to send the BASIC file to the service using the curl to send the binary
# to the service, and retrieve a build result.
#
# Syntax: build-with-curl.sh
#

set -eo pipefail

# Remove the success and failure content
rm -f data,ffd failed.log

echo Run on the build service
# Note: The curl -F option treats a `,` as a separator, so RISC OS
#       filenames can't just be given directly - instead we have
#       curl read the file from stdin.
STATUS_CODE=$(curl --silent -F source=@- -o data,ffd --write-out "%{http_code}" http://json.build.riscos.online/build/binary < myprogram,fd1)

if [[ "$STATUS_CODE" == 200 ]] ; then
    echo Success
else
    echo Failed
    mv data,ffd failed.log
    cat failed.log
    exit 1
fi
