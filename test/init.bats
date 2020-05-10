#!/usr/bin/env bats

load common
load git

setup(){
  repo_setup
  repo_dirty_worktree
}


teardown(){
  repo_teardown
}

@test "init - bare" {
  refute branch_exists "bookmarks"

  run git-bk init
  assert_success
  assert_line --partial "bookmarks"
  assert_line --partial "root-commit"
  assert_line --partial "Initial Commit"
  assert_line --partial "1 file changed, 0 insertions(+), 0 deletions(-)"
  assert_line --partial "create mode 100644 links"

  assert branch_exists "bookmarks"

  run file_exists_in_branch "bookmarks" "links"
  assert_success

  assert_equal "$(number_of_files bookmarks)" "1"
  assert_equal "$(last_commit_message bookmarks)" "Initial Commit"
  assert_equal "$(number_of_commits bookmarks)" "1"
}

@test "init - with --branch" {
  refute branch_exists "bookmarks"
  refute branch_exists "other-branch"

  run git-bk init --branch "other-branch"
  assert_success
  assert_line --partial "other-branch"
  assert_line --partial "root-commit"
  assert_line --partial "Initial Commit"
  assert_line --partial "1 file changed, 0 insertions(+), 0 deletions(-)"
  assert_line --partial "create mode 100644 links"

  assert branch_exists "other-branch"
  refute branch_exists "bookmarks"

  run file_exists_in_branch "other-branch" "links"
  assert_success

  assert_equal "$(number_of_files other-branch)" "1"
  assert_equal "$(last_commit_message other-branch)" "Initial Commit"
  assert_equal "$(number_of_commits other-branch)" "1"
}

@test "init - with --session" {
  run git-bk init --session="other-session"
  assert_success
  assert_line --partial "bookmarks"
  assert_line --partial "root-commit"
  assert_line --partial "Initial Commit"
  assert_line --partial "1 file changed, 0 insertions(+), 0 deletions(-)"
  assert_line --partial "create mode 100644 other-session"

  assert branch_exists "bookmarks"

  run file_exists_in_branch "bookmarks" "other-session"
  assert_success
  run file_exists_in_branch "bookmarks" "links"
  assert_failure

  assert_equal "$(number_of_files bookmarks)" "1"
  assert_equal "$(last_commit_message bookmarks)" "Initial Commit"
  assert_equal "$(number_of_commits bookmarks)" "1"
}


@test "init - with --session not on root" {
  cd staged-dir

  run git-bk init --session="other-session"
  assert_success
  assert_line --partial "bookmarks"
  assert_line --partial "root-commit"
  assert_line --partial "Initial Commit"
  assert_line --partial "1 file changed, 0 insertions(+), 0 deletions(-)"
  assert_line --partial "create mode 100644 other-session"

  assert branch_exists "bookmarks"

  run file_exists_in_branch "bookmarks" "other-session"
  assert_success
  run file_exists_in_branch "bookmarks" "links"
  assert_failure

  assert_equal "$(number_of_files bookmarks)" "1"
  assert_equal "$(last_commit_message bookmarks)" "Initial Commit"
  assert_equal "$(number_of_commits bookmarks)" "1"
}
