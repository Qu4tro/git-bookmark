#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup(){
  mkdir -p "$BATS_TMPDIR/test-git-bk"
  cd "$BATS_TMPDIR/test-git-bk"
  git init
  git commit -m "Master commit" --allow-empty

  # Manually setup our bookmarks
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

  # Dirty up the work tree
  touch staged
  git add staged

  touch untracked
}

teardown(){
  rm -rf "$BATS_TMPDIR/test-git-bk"
}

@test "edit - empty" {
  export EDITOR=echo
  git bk init --branch=other

  run git bk edit --branch=other
  assert_line "nothing to commit, working tree clean"
  assert_failure
}

@test "edit - bare" {
  run git bk edit --editor=echo
  assert_line "nothing to commit, working tree clean"
  assert_failure
}

@test "edit - with --branch" {
  run git bk edit --branch=bookmarks2 --editor=echo
  assert_line "nothing to commit, working tree clean"
  assert_failure
}

@test "edit - with --session" {
  run git bk edit --session=links2 --editor=echo
  assert_line "nothing to commit, working tree clean"
  assert_failure
}

@test "edit - with --editor" {
  run git bk edit --editor=rm --message="Removed file"
  assert_line --partial "bookmarks"
  assert_line --partial "delete mode"
  assert_line --partial "links"
  assert_success

  run git bk edit --editor=touch --message="ReAdded file"
  assert_line --partial "bookmarks"
  assert_line --partial "create mode"
  assert_line --partial "links"
}
