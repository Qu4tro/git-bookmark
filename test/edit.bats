#!/usr/bin/env bats

load common

setup(){
  repo_setup
  repo_manually_populate
  repo_dirty_worktree
}

teardown(){
  repo_teardown
}

@test "edit - empty" {
  run git-bk edit --branch=empty
  assert_line "nothing to commit, working tree clean"
  assert_failure
}


@test "edit - bare" {
  run git-bk edit
  assert_line "nothing to commit, working tree clean"
  assert_failure
}


@test "edit - with --branch" {
  run git-bk edit --branch=bookmarks2
  assert_line "nothing to commit, working tree clean"
  assert_failure
}

@test "edit - with --session" {
  run git-bk edit --session=links2
  assert_line "nothing to commit, working tree clean"
  assert_failure
}

@test "edit - with --editor" {
  run git-bk edit --branch=empty --editor=echo
  assert_line "nothing to commit, working tree clean"
  assert_failure

  run git-bk edit --editor=rm --message="Removed file"
  assert_line --partial "bookmarks"
  assert_line --partial "delete mode"
  assert_line --partial "links"
  assert_success

  run git-bk edit --editor=touch --message="ReAdded file"
  assert_line --partial "bookmarks"
  assert_line --partial "create mode"
  assert_line --partial "links"
}


@test "add - with --editor not on root" {
  cd staged-dir
  run git-bk edit --branch=empty --editor=echo
  assert_line "nothing to commit, working tree clean"
  assert_failure

  run git-bk edit --editor=rm --message="Removed file"
  assert_line --partial "bookmarks"
  assert_line --partial "delete mode"
  assert_line --partial "links"
  assert_success

  run git-bk edit --editor=touch --message="ReAdded file"
  assert_line --partial "bookmarks"
  assert_line --partial "create mode"
  assert_line --partial "links"
}
