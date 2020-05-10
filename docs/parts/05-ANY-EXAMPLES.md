
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

