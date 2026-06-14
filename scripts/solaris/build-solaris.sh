#!/usr/bin/bash
set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> SWT natives"
"$SCRIPT_DIR/build-swt-solaris.sh"

echo "==> Eclipse SDK (Maven verify)"
"$SCRIPT_DIR/build-eclipse-solaris.sh"
