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

@test "list - empty" {
  git-bk init --branch=other

  run git-bk list --branch=other
  refute_output
}

@test "list - bare" {
  run git-bk list
  assert_line "url1"
  assert_line "url2"

  assert_equal "$(git-bk list | wc -l)" 2
}

@test "list - with --branch" {
  run git-bk list --branch=bookmarks2
  assert_line "url5"
  assert_line "url6"

  assert_equal "$(git-bk list | wc -l)" 2
}

@test "list - with --session" {
  run git-bk list --session=links2
  assert_line "url3"
  assert_line "url4"

  assert_equal "$(git-bk list | wc -l)" 2
}
