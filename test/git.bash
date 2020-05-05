#!/usr/bin/env bash

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
