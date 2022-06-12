#!/usr/bin/env bash

# Generate the next version using the `shed version` command.
NEXT_VERSION=$(shed version)
COMMIT_TAG=v$NEXT_VERSION

# Generate a `pretty` changelog, and prepend its content at the top of the `./CHANGELOG.md` file.
shed changelog --type=pretty

# Generate a `raw` changelog, and overwrite the `changelog.txt` file with the new content, while moving the old content
# to the top of the `past_changelogs.txt` file.
shed changelog --type=raw

# Generate the next version using the `shed version` command and instead of outputting the value to stdout, write it
# directly in the `pubspec.yaml` file, on the line starting with `version: `.
shed version --update-pubspec

# Configure Git to use the `github-actions` bot.
# Subsequent commits will appear with the `github-actions[bot]` username on GitHub instead of `Unknown`
git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"
git remote set-url origin git@github.com:nunuazaidi/flutter_github_ci.git

# Stage all the changes, commit and tag them, using with the next release version as the tag value.
git add .
git commit -m "release: Build $COMMIT_TAG to staging environment [skip ci]"
git tag -a $COMMIT_TAG -m "$COMMIT_TAG"

# Merge the changes (performed above on `staging-prepare`) into `main` and push them, so that they can be made available
# in the next changes.
#
# The push to `main` would normally trigger the `post-review.yaml` workflow to be run, but since the commit message
# (above) ends in `[skip ci]`, the workflow is not triggered.
git checkout main
git merge staging-prepare
git push origin main

# Also merge the same changes into the `staging-deploy` branch, and push them. This push will specifically trigger the
# CD engine to start up, pick up all the changes on `staging-deploy` and deploy them to the staging environment.
git checkout staging-deploy
git merge staging-prepare
git push origin staging-deploy

# Push the new tag so that it can be made available in the repo.
git push origin $COMMIT_TAG