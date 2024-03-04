# Running BASIC through the RISC OS build service

This repository shows how you can run a BASIC program on the RISC OS build
service, and get the results back.

The supplied program merely calculates a table of Log entries for the
RISC OS sound system and returns this data.

The RISC OS build service returns content through the Clipboard, so
copying the file to the clipboard in the pogram indicates the data
that should be returned.

A description of how to handle running programs on the build service
can be found [here](https://build.riscos.online/ci-build.html#).

Other examples can be found in the GitHub topic '[riscos-ci](https://github.com/topics/riscos-ci)'.

Templates for use with GitLab and GitHub can be found in the [riscos-ci-templates](https://github.com/gerph/riscos-ci-templates) repository.

## Which example to use?

Which example in this repository is most appropriate for your use will
depend on the host system you are using, the tools that are available
and how much additional information you require.

* The `riscos-build-online` tool is build for Linux, and will work in
  CI systems like GitLab and GitHub on Linux (and in other places).
  It provides feedback as the command is running, and can write out
  files automatically.
* The `curl` method using binary output only produces output on
  completion. The simple binary form is useful if you expect the
  operation will always be successful.
* The `curl` method using JSON is useful if you want to see what happened
  during the run, or need to extract the information programatically.


## Using the riscos-build-online tool

The `riscos-build-online` tool is intended to make the process easier and
provide some degree of interactivity from the output.

The script `build-with-riscos-build-online.sh` will run on Linux (or MacOS
if you've built the tool there) and run the supplied program.


## Using curl (with simple binary output)

The service can also build simple binaries by being sent a file or
archive as a POST, and then returns you the binary output. Using
this method, there is no output returned unless the program exits
with a failure.

The script `build-with-curl.sh` will run on Linux or MacOS systems
and run the supplied program.



## Using curl (with JSON output)

If you need more information than just the output files, the build
service can produce JSON output as well. This allows the service to
report messages about how the build worked, and the output sent to
the screen as well as the resulting binary, in a structured format.

The script `build-with-curl-json.sh` will run on Linux or MacOS
systems and run the supplied program, printing out messages.

