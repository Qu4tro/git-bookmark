
## DESCRIPTION

`git-bookmark` is a simple script that can be used as a git subcommand. It adds some commands to interact with bookmark files on a separate branch, to help to store web sessions related to it.

The bookmark file format is a simple list of line separated URLs (Although no URL is ever checked for validity). It supports empty lines, leading/trailing whitespace and # comments.

Using the packaged `make install` also installs `git-bk` as an alias. This lets `git bk` be used for brevity sake.

The man page is available with `man git-bookmark` or at the [project gh pages](https://qu4tro.github.io/git-bookmark/).
