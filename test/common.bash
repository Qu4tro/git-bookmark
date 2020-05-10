#!/usr/bin/env bash

# shellcheck disable=SC2129

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

git-bk(){
  "$(dirname "$BATS_TEST_DIRNAME")/git-bookmark" "$@"
}

test_dir(){
  echo "$BATS_TMPDIR/test-git-bk-$BATS_TEST_NAME"
}

repo_setup(){
  # Setup our base git repo
  mkdir -p "$(test_dir)"
  cd "$(test_dir)" || exit 1
  git init
  git commit -m "Master commit" --allow-empty
}

repo_teardown(){
  # Just delete everything
  rm -rf "$(test_dir)"
}

repo_manually_populate(){
  # Add some bookmarks manually
  git checkout --orphan bookmarks
  rm -f links links2

  echo "url1" >> links
  echo "" >> links
  echo "   " >> links
  echo "   url2" >> links

  echo "url3 " >> links2
  echo "   url4 " >> links2
  git add links links2
  git commit -m "Initial Commit"

  git checkout --orphan bookmarks2
  rm -f links links2
  echo "url5#jwjiwjwiw" >> links
  echo "   url6  #jwiwjiwjw" >> links
  git add links
  git commit -m "Initial Commit"

  git checkout --orphan empty
  touch links
  git add links
  git commit -m "Initial Commit"
}

repo_dirty_worktree(){
  # Dirty up the work tree with staged and untracked files and directories
  
  mkdir staged-dir
  (cd staged-dir && touch staged-nested-file)
  touch staged-file
  git add staged-file staged-dir/staged-nested-file

  mkdir untracked-dir
  (cd untracked-dir && touch untracked-nested-file)
  touch untracked-file
  git add untracked-file untracked-dir/untracked-nested-file
  touch untracked
}
