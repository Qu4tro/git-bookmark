#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup(){
  mkdir -p "$BATS_TMPDIR/test-git-bk"
  cd "$BATS_TMPDIR/test-git-bk"
  git init
  git commit -m "Master commit" --allow-empty

  # Init some repos, so we can add in

  git bk init --branch empty
  git bk init --branch other_branch
  git bk init --session other_session

  # Dirty up the work tree
  touch staged
  git add staged

  touch untracked
}

no_changes_to_worktree(){
  :
}

teardown(){
  rm -rf "$BATS_TMPDIR/test-git-bk"
}

@test "add - bare" {
  run git bk add "url1"
  assert_line --partial "Added 1 new bookmarks"
  assert_line --partial "1 file changed"
  assert_line --partial "1 insertion"
  assert_success
}

@test "add - multiple" {
  run git bk add "url1" "url2 " "url3 # hey"
  assert_line --partial "Added 3 new bookmarks"
  assert_line --partial "1 file changed"
  assert_line --partial "3 insertion"
  assert_success
}


@test "add - with --branch" {
  run git bk add --branch=other_branch "url1"
  assert_line --partial "Added 1 new bookmarks"
  assert_line --partial "1 file changed"
  assert_line --partial "1 insertion"
  assert_success
}

@test "add - with --session" {
  run git bk add --session=other_session "url1"
  assert_line --partial "Added 1 new bookmarks"
  assert_line --partial "1 file changed"
  assert_line --partial "1 insertion"
  assert_success
}
