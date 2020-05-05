#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

setup(){
  mkdir -p "$BATS_TMPDIR/test-git-bk"
  cd "$BATS_TMPDIR/test-git-bk"
  git init
  git commit -m "Master commit" --allow-empty

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

branch_exists(){
  git show-ref --verify --quiet "refs/heads/$1"
}

last_commit_message(){
  git show --no-patch --format=%s "$1"
}

number_of_commits(){
  git rev-list --count "$1"
}

number_of_files(){
  git show --name-only --format= "$1" | wc -l
}

file_exists_in_branch(){
  git cat-file -e "$1:$2"
}

@test "init - bare" {
  refute branch_exists "bookmarks"

  run git bk init
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

  run git bk init --branch "other-branch"
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
  run git bk init --session="other-session"
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
