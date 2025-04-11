#!/bin/sh
set -e

PLUGIN_NAME="opnsense-theme-unsense"
VERSION="1.0"
PKG_NAME="${PLUGIN_NAME}-${VERSION}.txz"

OUTDIR="../../repo/FreeBSD:14:amd64"
PKGOUT="${OUTDIR}/${PKG_NAME}"

# cleanup
rm -rf "$OUTDIR/unpacked"
mkdir -p "$OUTDIR/unpacked"

echo "[+] Writing +MANIFEST"
cat > files/+MANIFEST <<EOF
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

echo "[+] Building ${PKG_NAME}"
tar --format=ustar -Jcf "$PKGOUT" -C files +MANIFEST usr

echo "[+] Extracting to build repo index"
tar -xf "$PKGOUT" -C "$OUTDIR/unpacked"

echo "[+] Creating repo.txz"
tar --format=ustar -Jcf "$OUTDIR/repo.txz" -C "$OUTDIR/unpacked" +MANIFEST usr

# cleanup
rm files/+MANIFEST

echo "[✓] Package and repo index ready:"
ls -lh "$PKGOUT" "$OUTDIR/repo.txz"
