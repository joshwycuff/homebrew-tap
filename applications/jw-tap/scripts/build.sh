#!/usr/bin/env bash

set -e

MODULE="github.com/joshwycuff/homebrew-tap/applications/jw-tap"
NAME="jw-tap"

if [ ! -e "main.go" ] ; then
  echo "[ERROR] Not in a directory with a main.go file" >&2
  exit 1
fi

if [ ! -z "$(git status --porcelain)" ]; then
  echo "[ERROR] Uncommitted changes detected" >&2
  git status --porcelain
  exit 1
fi

echo "[INFO] Removing dist/ directory"
rm -fr dist/

COMMIT_ID=$(git log -1 --format="%H" -- .)
TAG=$(git describe --tags --abbrev=0 $COMMIT)
VERSION=$(echo $TAG | cut -d'-' -f3)

echo "[INFO] COMMIT_ID: ${COMMIT_ID}"
echo "[INFO] TAG: ${TAG}"
echo "[INFO] VERSION: ${VERSION}"

# ldflags to embed build info into the binary
LDFLAGS="-X \"${MODULE}/internal.build.CommitId=${COMMIT_ID}\"
-X \"${MODULE}/internal.build.Tag=${TAG}\"
-X \"${MODULE}/internal.build.Version=${VERSION}\""

for os in darwin; do
  for arch in arm64; do
    echo "[INFO] Building: ${os} ${arch}"
    folder="${NAME}-${VERSION}-${os}-${arch}"
    output="dist/${folder}/${NAME}"
    GOOS=$os GOARCH=$arch CGO_ENABLED=0 \
      go build \
        -ldflags "${LDFLAGS}" \
        -o $output
    echo "[INFO] Output: ${output}"

    echo "[INFO] Archiving.."
    cd dist/
    archive="${folder}.tar.gz"
    tar -czvf $archive -C $folder $NAME
    cd ../
    echo "[INFO] Archive: dist/${archive}"
  done
done
