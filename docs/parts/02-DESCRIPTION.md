
## DESCRIPTION

Simple git subcommand to save URLs into append files in a separate branch. The goal is to keep web sessions related to a repository within it.

The bookmark file format supports # comments and ignores any extra whitespace. URLs are never checked for validity.

Using the packaged `make install` also installs `git-bk` as an alias. This lets `git bk` be used for brevity sake.
