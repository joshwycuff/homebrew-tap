#!/usr/bin/env bash

NAME="jw-tap"

if [ ! -d "dist/" ] ; then
  echo "[ERROR] Could not find a dist/ directory" >&2
  exit 1
fi

if [ ! -z "$(git status --porcelain)" ]; then
  echo "[ERROR] Uncommitted changes detected" >&2
  git status --porcelain
  exit 1
fi

COMMIT_ID=$(git log -1 --format="%H" -- .)
TAG=$(git describe --tags --abbrev=0 $COMMIT)
VERSION=$(echo $TAG | cut -d'-' -f3)

echo "[INFO] COMMIT_ID: ${COMMIT_ID}"
echo "[INFO] TAG: ${TAG}"
echo "[INFO] VERSION: ${VERSION}"

# check for existence of release assets
for os in darwin; do
  for arch in arm64; do
    asset="${NAME}-${VERSION}-${os}-${arch}.tar.gz"
    if [ ! -e "dist/${asset}" ]; then
      echo "[ERROR] Asset not found: ${asset}"
      exit 1
    fi
  done
done

NOTES=$(git show $COMMIT_ID -- CHANGELOG.md | grep '^+[^+]*' | sed '1d' | sed 's/^+//')

# create the draft release
gh release create \
  --draft \
  --latest \
  --verify-tag \
  --target $COMMIT_ID \
  --title $TAG \
  --notes "$NOTES" \
  $TAG

# publish artifacts
for os in darwin; do
  for arch in arm64; do
    asset="${NAME}-${VERSION}-${os}-${arch}.tar.gz"
    echo "[INFO] Publishing: ${asset}"
    gh release upload \
      $TAG \
      dist/$asset
  done
done

# publish the release
gh release edit $TAG --draft=false
