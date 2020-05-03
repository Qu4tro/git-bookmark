#!/usr/bin/env bash

# shellcheck disable=SC2154,SC2002

eval "$(
  docopts -V - -h - : "$@" <<EOF
Usage:
    git-bk init [--session=<name>] [--branch=<name>]
    git-bk add  [--session=<name>] [--branch=<name>] <url>...
    git-bk edit [--session=<name>] [--branch=<name>] [--editor=<executable>]
    git-bk open [--session=<name>] [--branch=<name>] [--browser=<executable>]
    git-bk list [--session=<name>]
    git-bk -h | --help
    git-bk --version

    Options:
    -h --help               Show this screen.
    --version               Show version.

    --session=<name>        Name of the bookmark file
                            [default: master].

    --branch=<name>         Name of the branch
                            [default: bookmarks].

    --editor=<executable>   Editor to use when editing a bookmark file 
                            [default: $EDITOR].

    --browser=<executable>  Browser to use when opening from a bookmark file
                            [default: $BROWSER].

----
  git bk 0.1.0
  Copyright (C) 2020 Xavier Francisco
  License MIT
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.
EOF
)"

require_git_repo() {
  # Abort when a git repo isn't found
  if ! git rev-parse --git-dir >/dev/null 2>/dev/null; then
    echo "Not inside a git repo. Aborting"
    exit 1
  fi
}

enter_bookmark_branch() {
  # Enter the branch to work with
  clone_dir="$(mktemp -d)"
  if ! git clone . --branch="$branch" "$clone_dir" 2>/dev/null; then
    echo 'Bookmark branch not initialized. Aborting.'
    echo ''
    echo "Tip: Run 'git bk init'"
    exit 1
  fi

  # Change directory to our cloned repo
  # Trap EXIT to git checkout to the original branch
  cd "$clone_dir" > /dev/null || exit 1
}

commit() {
  # Add our changes and commit them
  # Pass all arguments to `git commit`
  # Push to original repo
  git add "$session"
  git commit "$@"
  git push 2>/dev/null
}

add() {
  # Just append the urls with a newline

  echo "$1" >>"$session"
}

listing() {
  # Read our bookmarks file
  # Strip: comments, empty lines, leading&trailing spaces

  cat "$session" |
    sed -e 's/\s*#.*$//' |
    sed 's/^ *//; s/ *$//; /^$/d'
}

# Begin
require_git_repo

# When Initiating
if $init; then
  # shellcheck disable=SC2064
  trap "git checkout -q $(git rev-parse --symbolic-full-name --abbrev-ref HEAD)" EXIT
  git checkout --orphan "$branch"
  git rm -rf .
  touch "$session"
  commit -m "Initial Commit"

# When Adding
elif $add; then
  enter_bookmark_branch
  for u in "${url[@]}"; do
    add "${u}"
  done
  commit -m "Added ${#url[@]} new bookmarks"

# When Editing
elif $edit; then
  enter_bookmark_branch
  "$editor" "$session"
  commit

# When Opening
elif $open; then
  enter_bookmark_branch
  listing | xargs -L1 "$browser"

# When Listing
elif $list; then
  exec 2>/dev/null
  enter_bookmark_branch
  listing
fi
