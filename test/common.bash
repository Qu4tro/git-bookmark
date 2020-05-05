
# shellcheck disable=SC2129

repo_setup(){
  # Setup our base git repo
  mkdir -p "$BATS_TMPDIR/test-git-bk"
  cd "$BATS_TMPDIR/test-git-bk" || exit 1
  git init
  git commit -m "Master commit" --allow-empty
}

repo_manually_populate(){
  # Add some bookmarks manually
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
}

repo_manually_populate(){
  # Add some bookmarks manually
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

  git checkout --orphan empty
  touch links
  git add links
  git commit -m "Initial Commit"
}

repo_dirty_worktree(){
  # Dirty up the work tree
  touch staged
  git add staged

  touch untracked
}


repo_teardown(){
  # Just delete everything
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
