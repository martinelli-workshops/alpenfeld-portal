#!/bin/bash
set -e
BRANCH="workshop/${GITHUB_USER}"

git fetch origin
if git ls-remote --exit-code --heads origin "$BRANCH" > /dev/null 2>&1; then
  echo "Branch $BRANCH existiert, wird ausgecheckt"
  git checkout "$BRANCH"
else
  echo "Erstelle Branch $BRANCH"
  git checkout -b "$BRANCH"
  git push -u origin "$BRANCH"
fi