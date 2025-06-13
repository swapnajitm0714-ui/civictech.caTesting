#!/bin/bash
set -euo pipefail

echo "🔍 Scanning archives for categories..."

ARCHIVES_DIR="archives"
TMP_CATEGORIES=$(mktemp)
FINAL_CATEGORIES="_data/categories.yml"

cleanup() {
  rm -f "$TMP_CATEGORIES"
}
trap cleanup EXIT

# Extract categories under the 'categories:' key
find "$ARCHIVES_DIR" -type f -name "*.md" -print0 | while IFS= read -r -d '' file; do
  echo "📄 Checking $file"

  awk '
    BEGIN { in_yaml=0; in_cats=0 }
    /^---$/ { in_yaml = !in_yaml; next }

    in_yaml {
      if ($0 ~ /^categories:/) {
        in_cats = 1
        next
      }

      if (in_cats) {
        if ($0 ~ /^[^[:space:]]/ || $0 ~ /^ *[a-zA-Z0-9_-]+:/) {
          in_cats = 0
        } else if ($0 ~ /^ *- /) {
          gsub(/^ *- /, "", $0)
          print $0
        }
      }
    }
  ' "$file" >> "$TMP_CATEGORIES"
done

# Validate
if [ ! -s "$TMP_CATEGORIES" ]; then
  echo "⚠️ No categories found. Exiting."
  exit 1
fi

echo "🛠 Building categories.yml..."
sort -u "$TMP_CATEGORIES" | awk '
  BEGIN { print "categories:" }
  NF > 0 { printf "  - \"%s\"\n", $0 }
' > "$FINAL_CATEGORIES"

echo "🎉 Categories written to $FINAL_CATEGORIES"
