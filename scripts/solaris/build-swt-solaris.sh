#!/usr/bin/bash
set -eo pipefail

die() { echo "ERROR: $*" >&2; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AGG="$(cd "$SCRIPT_DIR/../.." && pwd)"

LIB="$AGG/eclipse.platform.swt/bundles/org.eclipse.swt/Eclipse SWT PI/gtk/library"
OUT="$AGG/eclipse.platform.swt/binaries/org.eclipse.swt.gtk.solaris.x86_64"

export SWT_JAVA_HOME="${SWT_JAVA_HOME:-/usr/jdk/instances/openjdk21.0.8}"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH:-/usr/lib/amd64/pkgconfig}"
export CC="${CC:-gcc}"
export OUTPUT_DIR="$OUT"
export NO_STRIP=1

cd "$LIB"

ln -sf "../../../Eclipse SWT/common/library/make_common.mak" make_common.mak
ln -sf "../../../Eclipse SWT/common/library/swt.c" swt.c
ln -sf "../../../Eclipse SWT/common/library/swt.h" swt.h
ln -sf "../../../Eclipse SWT/common/library/callback.c" callback.c
ln -sf "../../../Eclipse SWT/common/library/callback.h" callback.h
ln -sf "../../common/library/c.c" c.c
ln -sf "../../common/library/c.h" c.h
ln -sf "../../common/library/c_stats.c" c_stats.c
ln -sf "../../common/library/c_stats.h" c_stats.h
ln -sf "../../common/library/c_structs.c" c_structs.c
ln -sf "../../common/library/c_structs.h" c_structs.h
ln -sf "../../../Eclipse SWT AWT/gtk/library/swt_awt.c" swt_awt.c
for pair in \
  "../../../Eclipse SWT OpenGL/glx/library/glx.c:glx.c" \
  "../../../Eclipse SWT OpenGL/glx/library/glx.h:glx.h" \
  "../../../Eclipse SWT OpenGL/glx/library/glx_stats.c:glx_stats.c" \
  "../../../Eclipse SWT OpenGL/glx/library/glx_stats.h:glx_stats.h" \
  "../../../Eclipse SWT OpenGL/glx/library/glx_structs.c:glx_structs.c" \
  "../../../Eclipse SWT OpenGL/glx/library/glx_structs.h:glx_structs.h" \
  "../../../Eclipse SWT PI/cairo/library/cairo.c:cairo.c" \
  "../../../Eclipse SWT PI/cairo/library/cairo.h:cairo.h" \
  "../../../Eclipse SWT PI/cairo/library/cairo_custom.h:cairo_custom.h" \
  "../../../Eclipse SWT PI/cairo/library/cairo_stats.c:cairo_stats.c" \
  "../../../Eclipse SWT PI/cairo/library/cairo_stats.h:cairo_stats.h" \
  "../../../Eclipse SWT PI/cairo/library/cairo_structs.c:cairo_structs.c" \
  "../../../Eclipse SWT PI/cairo/library/cairo_structs.h:cairo_structs.h" \
  "../../../Eclipse SWT WebKit/gtk/library/webkitgtk.c:webkitgtk.c" \
  "../../../Eclipse SWT WebKit/gtk/library/webkitgtk.h:webkitgtk.h" \
  "../../../Eclipse SWT WebKit/gtk/library/webkitgtk_custom.c:webkitgtk_custom.c" \
  "../../../Eclipse SWT WebKit/gtk/library/webkitgtk_custom.h:webkitgtk_custom.h" \
  "../../../Eclipse SWT WebKit/gtk/library/webkitgtk_stats.c:webkitgtk_stats.c" \
  "../../../Eclipse SWT WebKit/gtk/library/webkitgtk_stats.h:webkitgtk_stats.h" \
  "../../../Eclipse SWT WebKit/gtk/library/webkitgtk_structs.c:webkitgtk_structs.c" \
  "../../../Eclipse SWT WebKit/gtk/library/webkitgtk_structs.h:webkitgtk_structs.h"; do
  ln -sf "${pair%%:*}" "${pair##*:}"
done

if ! grep -q "solaris: keep JNI stub" os.h; then
  die "os.h Solaris patch not applied. Run apply-patches.sh first."
fi

./build.sh clean -gtk3 install
cp -p libswt-*.so "$OUT/"
echo "Done: $OUT"
ls -la "$OUT"/*.so
