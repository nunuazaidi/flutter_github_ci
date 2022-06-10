#!/usr/bin/env bash

NEXT_VERSION=$(shed version)

shed changelog --type=pretty --verbose
shed changelog --type=raw --verbose
shed version --update-pubspec --verbose

git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"
git remote set-url origin https://${{secrets.FLUTTER_GITHUB_CI_ACCESS_TOKEN}}@github.com/nunuazaidi/flutter_github_ci.git

git add .
git commit -m "release: Build v$NEXT_VERSION to staging environment [skip ci]"
git tag -a v$NEXT_VERSION -m "v$NEXT_VERSION"

git checkout main
git merge staging-prepare
git push origin main

git checkout staging-deploy
git merge staging-prepare
git push origin staging-deploy

git push --follow-tags