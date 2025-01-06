#!/usr/bin/env bash

export GH_ORG="joshwycuff"
export GH_REPO="homebrew-tap"
export NAME="jw-tap"
export DESC="jw-tap: A helper CLI for the joshwycuff/homebrew-tap repository"

if [ ! -d "dist/" ] ; then
  echo "[ERROR] Could not find a dist/ directory" >&2
  exit 1
fi

if [ ! -z "$(git status --porcelain)" ]; then
 echo "[ERROR] Uncommitted changes detected" >&2
 git status --porcelain
 exit 1
fi

export COMMIT_ID=$(git log -1 --format="%H" -- .)
export TAG=$(git describe --tags --abbrev=0 $COMMIT)
export VERSION=$(echo $TAG | cut -d'-' -f3)

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

# check for existence of release and that it is published (not a draft)
if [[ $(gh release view --repo $GH_ORG/$GH_REPO $TAG --json isDraft --jq ".isDraft") == "true" ]]; then
  echo "[ERROR] Github Release ${TAG} is still a draft" >&2
  exit 1
fi

export ARM64_URL="https://github.com/${GH_ORG}/${GH_REPO}/releases/download/${NAME}-${VERSION}/${NAME}-${VERSION}-darwin-arm64.tar.gz"

echo "[INFO] ARM64_URL: ${ARM64_URL}"

export ARM64_SHA256=$(shasum -a 256 dist/${NAME}-${VERSION}-darwin-arm64.tar.gz | awk '{print $1}')

echo "[INFO] ARM64_SHA256: ${ARM64_SHA256}"

envsubst < templates/jw-tap.rb.tmpl > ../../Formula/$NAME.rb
