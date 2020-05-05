#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'
load common

setup(){
  repo_setup
  repo_manually_populate
  repo_dirty_worktree
}

teardown(){
  repo_teardown
}

@test "add - bare" {
  run git-bk add "url1"
  assert_line --partial "Added 1 new bookmarks"
  assert_line --partial "1 file changed"
  assert_line --partial "1 insertion"
  assert_success
}

@test "add - multiple" {
  run git-bk add "url1" "url2 " "url3 # hey"
  assert_line --partial "Added 3 new bookmarks"
  assert_line --partial "1 file changed"
  assert_line --partial "3 insertion"
  assert_success
}


@test "add - with --branch" {
  run git-bk add --branch=bookmarks2 "url1"
  assert_line --partial "Added 1 new bookmarks"
  assert_line --partial "1 file changed"
  assert_line --partial "1 insertion"
  assert_success
}

@test "add - with --session" {
  run git-bk add --session=other_session "url1"
  assert_line --partial "Added 1 new bookmarks"
  assert_line --partial "1 file changed"
  assert_line --partial "1 insertion"
  assert_success
}
