#!/bin/sh
set -ex

PLUGIN_NAME="opnsense-theme-unsense"
VERSION="1.0"
WORKDIR="work"
DEST="$WORKDIR/${PLUGIN_NAME}-${VERSION}.txz"

mkdir -p "$WORKDIR"

# place +MANIFEST next to files/
cat > "files/+MANIFEST" <<EOF
name: ${PLUGIN_NAME}
version: "${VERSION}"
comment: "Custom OPNsense Theme"
maintainer: you@example.com
categories: [themes]
prefix: /
licenselogic: single
licenses: [BSD2CLAUSE]
www: https://github.com/yourname/unsense-theme
arch: any
origin: ${PLUGIN_NAME}
EOF

# build the txz from inside files/
tar --format=ustar -Jcf "$DEST" -C files +MANIFEST usr

# clean up (optional)
rm files/+MANIFEST
