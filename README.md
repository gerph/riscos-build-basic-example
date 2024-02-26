# Running BASIC through the RISC OS build service

This repository shows how you can run a BASIC program on the RISC OS build
service, and get the results back.

The supplied program merely calculates a table of Log entries for the
RISC OS sound system and returns this data.

The RISC OS build service returns content through the Clipboard, so
copying the file to the clipboard in the pogram indicates the data
that should be returned.


## Using the riscos-build-online tool

The `riscos-build-online` tool is intended to make the process easier and
provide some degree of interactivity from the output.

The script `build-with-riscos-build-online.sh` will run on Linux (or MacOS
if you've built the tool there) and run the supplied program.


## Using curl

(FIXME)

