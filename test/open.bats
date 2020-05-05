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

@test "open - empty" {
  git-bk init --branch=other

  run git-bk open --branch=other --browser=echo
  refute_output
}

@test "open - bare" {
  run git-bk open --browser=echo
  assert_output "url1 url2"

}

@test "open - with --branch" {
  run git-bk open --branch=bookmarks2 --browser=echo
  assert_output "url5 url6"
}

@test "open - with --session" {
  run git-bk open --session=links2 --browser=echo
  assert_output "url3 url4"
}
