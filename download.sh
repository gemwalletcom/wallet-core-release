#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

if [ -z "$GITHUB_TOKEN" ]; then
  echo "GITHUB_TOKEN is not set"
  exit 1
fi

VERSION=$1

mkdir -p ${VERSION}

cd ${VERSION}

wget_with_auth() {
    wget -q --show-progress --header="Authorization: token $GITHUB_TOKEN" $@
}

download_artifact() {
    artifact_id=$1
    files=$2
    base_url=https://maven.pkg.github.com/trustwallet/wallet-core/com.trustwallet/${artifact_id}

    for file in ${files[@]}; do
        wget_with_auth ${base_url}/${VERSION}/${file}
        wget_with_auth ${base_url}/${VERSION}/${file}.sha1
        if [[ $(shasum ${file} | awk '{print $1}') != $(cat ${file}.sha1) ]]; then
            echo "<== Checksum mismatch for ${file}"
            exit 1
        fi
    done
}

download_wallet_core() {
    echo "==> Downloading Wallet Core $VERSION"
    artifact_id=wallet-core
    files=("${artifact_id}-${VERSION}.aar" "${artifact_id}-${VERSION}-sources.jar")
    download_artifact ${artifact_id} ${files[@]}
}

download_wallet_core_proto() {
    echo "==> Downloading Wallet Core Proto $VERSION"
    artifact_id=wallet-core-proto
    files=("${artifact_id}-${VERSION}.jar" "${artifact_id}-${VERSION}-sources.jar")
    download_artifact ${artifact_id} ${files[@]}
}

download_wallet_core
download_wallet_core_proto

echo "<== Done."
