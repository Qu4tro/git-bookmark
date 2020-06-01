git-bookmark(1) -- Keep your bookmarks with your repository
=============================================

## SYNOPSIS

**git-bookmark** init [--session=<name>] [--branch=<name>] [--gitv]  
**git-bookmark** add  [--session=<name>] [--branch=<name>] [--gitv] <url>...  
**git-bookmark** list [--session=<name>] [--branch=<name>] [--gitv]  
**git-bookmark** open [--session=<name>] [--branch=<name>] [--gitv] [--browser=<executable>]  
**git-bookmark** edit [--session=<name>] [--branch=<name>] [--gitv] [--editor=<executable>] [--message=<message>]  
**git-bookmark** -h | --help  
**git-bookmark** --version  

## DESCRIPTION

`git-bookmark` is a simple script that doubles as a git subcommand. It makes available some commands to interact with bookmark files on a separate branch, to help to store web sessions related to it.

The bookmark file format is a simple list of line separated URLs (Although no URL is ever checked for validity). It supports empty lines, leading/trailing whitespace and # comments.

Using the packaged `make install` also installs `git-bk` as an alias. This lets `git bk` be used for brevity sake.

The man page is available with `man git-bookmark` or at the [project gh pages](https://qu4tro.github.io/git-bookmark/).

## OPTIONS

 * `-h`, `--help` :
   Displays the help screen.

 * `--version` :
   Displays version information.

 * `--session=<name>` :
   Name of the bookmark file [default: links].

 * `--branch=<name>` :
   Name of the branch to look for the bookmark file [default: bookmarks].

 * `--editor=<executable>` :
   Editor to use when editing a bookmark file [default: `$EDITOR`].

 * `--message=<message>` :
   Commit message when editing. When ommited it will prompt like git does.

 * `--browser=<executable>` :
   Browser to use when opening from a bookmark file [default: `$BROWSER`].

 * `--gitv` :
   Show all of the underlyings git commands output.

## EXAMPLES

Start by **initializing** a new branch to keep the bookmarks within:

    $ git bk init

You may not like the default branch or you may want to use multiple branches. You need to **initialize** for any branch you use.

    $ git bk init --branch=other

**Initializing** is optional if the branch already exists.

New bookmarks can be easily **added**. Each `add` command is a commit on the underlying branch:

    $ git bk add https://github.com/stephenmathieson/git-standup
    $ git bk add https://github.com/basherpm/basher https://en.wikipedia.org/wiki/Man_page

When **adding** the defaults can be overriden with their respective options:

    $ git bk add --branch=other --session=local http://127.0.0.1:35729/

Comments can be **added** inline:

    $ git bk add --branch=other --session=local "http://127.0.0.1:8000/ # Server"


The bookmarks can be **listed** as well:

    $ git bk list
    https://github.com/stephenmathieson/git-standup
    https://github.com/basherpm/basher
    https://en.wikipedia.org/wiki/Man_page

    $ git bk list --branch=other --session=local
    http://127.0.0.1:35729/
    http://127.0.0.1:8000/


If more manual intervention you can **edit** the file by hand:

    $ git bk edit

By default, it uses `$EDITOR`, but anything in `$PATH` can be specified:

    $ git bk edit --editor=cat --gitv
    https://github.com/stephenmathieson/git-standup
    https://github.com/basherpm/basher
    https://en.wikipedia.org/wiki/Man_page
    On branch bookmarks
    Your branch is up to date with 'origin/bookmarks'.

    nothing to commit, working tree clean

We can see here with the help of `--gitv option, that no commit is generated when no changes are made when editing.

We're here.
Finally, we've arrived to our end **goal**! To **open** the saved bookmarks in your `$BROWSER` simply run:

    $ git bk open

And of course, we can use any of usual options when **opening**:

    $ git bk open --browser=echo --session=local --branch=other
    http://127.0.0.1:35729/
    http://127.0.0.1:8000/


## COPYRIGHT

**git-bookmark** - Copyright 2020, Xavier Francisco.
Released under the MIT license.

## SEE ALSO

git(1)
