#!/bin/bash
set -e

printf "\e[33;1m%s\e[0m\n" 'Pre-Commit'
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Undo the stash of the files
pop_stash_files () {
    if [ -n "$hasChanges" ]; then
        printf "\e[33;1m%s\e[0m\n" '=== Applying git stash changes ==='
        git stash pop
    fi
}

# Stash unstaged files
hasChanges=$(git diff)
if [ -n "$hasChanges" ]; then
    printf "\e[33;1m%s\e[0m\n" 'Stashing unstaged changes'
    git stash push --keep-index
fi
# Flutter Analyzer
printf "\e[33;1m%s\e[0m\n" '=== Running Flutter analyzer ==='
flutter analyze
if [ $? -ne 0 ]; then
  printf "\e[31;1m%s\e[0m\n" '=== Flutter analyzer error ==='
  pop_stash_files
  exit 1
fi
printf "\e[33;1m%s\e[0m\n" 'Finished running Flutter analyzer'
printf '%s\n' "${avar}"

# Unit tests
printf "\e[33;1m%s\e[0m\n" '=== Updating version number ==='
sh $SCRIPT_DIR/../../scripts/increment-version.sh $SCRIPT_DIR/../../pubspec.yaml
if [ $? -ne 0 ]; then
  printf "\e[31;1m%s\e[0m\n" '=== Error while incrementing version ==='
  pop_stash_files
  exit 1
fi

git add pubspec.yaml

pop_stash_files
