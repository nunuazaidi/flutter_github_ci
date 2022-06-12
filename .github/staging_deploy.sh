#!/usr/bin/env bash

# Generate the next version using the `shed version` command.
NEXT_VERSION=$(shed version)

# Generate both `pretty` and `raw` changelogs, writing them to their respective files.
shed changelog --type=pretty --verbose
shed changelog --type=raw --verbose
shed version --update-pubspec --verbose

# Configure Git to use the `github-actions` bot.
# Subsequent commits will appear with the `github-actions[bot]` username on GitHub instead of `Unknown`
git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"
git remote set-url origin git@github.com:nunuazaidi/flutter_github_ci.git

# Stage all the changes, commit and tag them, using with the next release version as the tag value.
# Without the `[skip ci]` at the end of the commit message, the `post_review.yaml` workflow will be triggered as soon as
# a push to `main` is made (below).
git add .
git commit -m "release: Build v$NEXT_VERSION to staging environment [skip ci]"
git tag -a v$NEXT_VERSION -m "v$NEXT_VERSION"

# Merge the changes (performed above on `staging-prepare`) into `main` and push them, so that they can be made available
# in the next changes.
git checkout main
git merge staging-prepare
git push origin main

# Also merge the same changes into the `staging-deploy` branch, and push them. This push will specifically trigger the
# CD engine to start up, pick up all the changes on `staging-deploy` and deploy them to the staging environment.
git checkout staging-deploy
git merge staging-prepare
git push origin staging-deploy

# Push the new tag so that it can be made available in the repo.
git push --follow-tags