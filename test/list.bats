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

@test "list - empty" {
  git bk init --branch=other

  run git bk list --branch=other
  refute_output
}

@test "list - bare" {
  run git bk list
  assert_line "url1"
  assert_line "url2"

  assert_equal "$(git bk list | wc -l)" 2
}

@test "list - with --branch" {
  run git bk list --branch=bookmarks2
  assert_line "url5"
  assert_line "url6"

  assert_equal "$(git bk list | wc -l)" 2
}

@test "list - with --session" {
  run git bk list --session=links2
  assert_line "url3"
  assert_line "url4"

  assert_equal "$(git bk list | wc -l)" 2
}
