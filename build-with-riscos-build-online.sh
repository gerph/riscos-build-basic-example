#!/bin/bash
##
# Script to send the BASIC file to the service using the riscos-build-online
# tool. Useful on Linux as part of CI.
# On other systems you may have to build the tool yourself.
#
# Syntax: build-with-riscos-build-online.sh
#

set -eo pipefail

# Fetch the build client
echo Obtain build client
if [ "$(uname -s)" != 'Darwin' ] ; then
    RISCOS_BUILD_ONLINE=./riscos-build-online
    curl -s -L -o riscos-build-online https://github.com/gerph/robuild-client/releases/download/v0.05/riscos-build-online && chmod +x riscos-build-online
else
    # On other macOS, assume you've built it in your path
    RISCOS_BUILD_ONLINE=riscos-build-online
fi

# Send the archive file to build service
echo Run on the build service
"${RISCOS_BUILD_ONLINE}" -i myprogram,fd1 -o data
