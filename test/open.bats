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

@test "open - empty" {
  git bk init --branch=other

  run git bk open --branch=other --browser=echo
  refute_output
}

@test "open - bare" {
  run git bk open --browser=echo
  assert_output "url1 url2"

}

@test "open - with --branch" {
  run git bk open --branch=bookmarks2 --browser=echo
  assert_output "url5 url6"
}

@test "open - with --session" {
  run git bk open --session=links2 --browser=echo
  assert_output "url3 url4"
}
