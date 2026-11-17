#!/usr/bin/env bash
set -Eeuo pipefail

usage() {
  cat <<'EOF'
Usage: package_binary_release.sh [options]

Build a binary-only Phantom release archive from the generated build output.
This keeps the engine executable and runtime files, but excludes build
intermediates such as bin/obj and other development-only directories.

Options:
  --root PATH          Path to the Phantom repository root. Default: repository root.
  --output PATH        Output archive path. Default: ./phantom-binary-release.tar.gz
  --name NAME          Archive package name. Default: phantom-binary-release
  --platform NAME      Optional platform label (linuxbsd, windows, macos, etc.)
  --clean              Remove the build root's obj directory after packaging.
  -h, --help           Show this help.
EOF
}

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUTPUT="${ROOT}/phantom-binary-release.tar.gz"
PACKAGE_NAME="phantom-binary-release"
PLATFORM=""
CLEAN_AFTER=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --root)
      ROOT="$2"
      shift 2
      ;;
    --output)
      OUTPUT="$2"
      shift 2
      ;;
    --name)
      PACKAGE_NAME="$2"
      shift 2
      ;;
    --platform)
      PLATFORM="$2"
      shift 2
      ;;
    --clean)
      CLEAN_AFTER=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

ROOT="$(cd "$ROOT" && pwd)"
OUTPUT_DIR="$(dirname "$OUTPUT")"
mkdir -p "$OUTPUT_DIR"

if [[ ! -d "$ROOT/bin" ]]; then
  echo "No build output directory found at: $ROOT/bin" >&2
  echo "Build Phantom first, then run this script again." >&2
  exit 1
fi

if [[ -n "$PLATFORM" ]]; then
  PACKAGE_NAME="${PACKAGE_NAME}-${PLATFORM}"
fi

STAMP="$(date +%Y%m%d-%H%M%S)"
WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/phantom-binary-release-${STAMP}-XXXXXX")"
trap 'rm -rf "$WORK_DIR"' EXIT

PACKAGE_ROOT="$WORK_DIR/$PACKAGE_NAME"
mkdir -p "$PACKAGE_ROOT"

cp "$ROOT/LICENSE.txt" "$PACKAGE_ROOT/"
cp "$ROOT/COPYRIGHT.txt" "$PACKAGE_ROOT/"

# Copy only engine/runtime artifacts from bin/, excluding build intermediates.
while IFS= read -r -d '' file; do
  rel="${file#"$ROOT/"}"

  # Skip source/object directories and obviously non-runtime outputs.
  if [[ "$rel" == bin/obj* || "$rel" == bin/.scons* || "$rel" == *.obj || "$rel" == *.o || "$rel" == *.a ]]; then
    continue
  fi

  if [[ "$rel" != bin/* ]]; then
    continue
  fi

  dest="$PACKAGE_ROOT/${rel#bin/}"
  mkdir -p "$(dirname "$dest")"

  case "$file" in
    *.exe|*.dll|*.so|*.dylib|*.bundle|*.framework|*.app|*.pdb|*.sym)
      cp "$file" "$dest"
      ;;
    *)
      # Include the engine binary itself and any runtime launchers even if they
      # do not use the standard extensions above.
      if [[ "$(basename "$file")" =~ ^(phantom|redot|godot).* ]]; then
        cp "$file" "$dest"
      fi
      ;;
  esac
done < <(find "$ROOT/bin" -type f -not -path '*/obj/*' -not -path '*/obj' -print0)

if [[ ! -e "$PACKAGE_ROOT" || -z "$(find "$PACKAGE_ROOT" -mindepth 1 -maxdepth 1 -print -quit 2>/dev/null)" ]]; then
  echo "No runtime artifacts were found under $ROOT/bin." >&2
  echo "Make sure the engine was built and the binary output exists." >&2
  exit 1
fi

if [[ "$OUTPUT" == *.zip ]]; then
  (cd "$WORK_DIR" && zip -rq "${OUTPUT##*/}" "$PACKAGE_NAME")
  mv "$WORK_DIR/${OUTPUT##*/}" "$OUTPUT"
elif [[ "$OUTPUT" == *.tar.gz || "$OUTPUT" == *.tgz ]]; then
  tar -czf "$OUTPUT" -C "$WORK_DIR" "$PACKAGE_NAME"
else
  tar -czf "$OUTPUT" -C "$WORK_DIR" "$PACKAGE_NAME"
fi

if [[ "$CLEAN_AFTER" -eq 1 ]]; then
  rm -rf "$ROOT/bin/obj"
  echo "Removed $ROOT/bin/obj"
fi

echo "Binary-only release written to: $OUTPUT"
