#!/usr/bin/bash
set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AGG="$(cd "$SCRIPT_DIR/../.." && pwd)"
LOG="${BUILD_LOG:-$AGG/build-eclipse-solaris.log}"

cd "$AGG"
export MAVEN_OPTS="${MAVEN_OPTS:--Xmx4g}"
export SWT_JAVA_HOME="${SWT_JAVA_HOME:-/usr/jdk/instances/openjdk21.0.8}"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH:-/usr/lib/amd64/pkgconfig}"

EXCL="!equinox.p2/bundles/org.eclipse.equinox.p2.tests,\
!equinox.p2/bundles/org.eclipse.equinox.p2.tests.discovery,\
!equinox.p2/bundles/org.eclipse.equinox.p2.tests.ui,\
!equinox.p2/bundles/org.eclipse.equinox.p2.tests.verifier,\
!eclipse.platform.releng:org.eclipse.sdk.tests,\
!products/eclipse-junit-tests,\
!sites/eclipse-platform-repository"

echo "[$(date)] Eclipse Solaris verify ($AGG)" | tee -a "$LOG"
mvn verify -DskipTests=true -Dmaven.test.skip=true \
  -Dtycho.disableP2Mirrors=true -Declipse.p2.mirrors=false \
  --batch-mode -pl "$EXCL" 2>&1 | tee -a "$LOG"
echo "[$(date)] exit=${PIPESTATUS[0]}" | tee -a "$LOG"
exit ${PIPESTATUS[0]}
