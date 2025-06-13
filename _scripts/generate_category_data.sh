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

# Extract categories from front matter
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

if [ ! -s "$TMP_CATEGORIES" ]; then
  echo "⚠️ No categories found. Exiting."
  exit 1
fi

echo "🛠 Building categories.yml..."
echo "{}" > "$FINAL_CATEGORIES"

sort -u "$TMP_CATEGORIES" | while read -r category; do
  [ -z "$category" ] && continue

  if [[ "$category" != */* ]]; then
    echo "⚠️ Skipping un-namespaced category: $category"
    continue
  fi

  ns="${category%%/*}"
  value="${category#*/}"

  printf "%s\n" "$ns:$value" >> "$TMP_CATEGORIES.ns"
done

# Build grouped YAML
{
  echo ""
  sort -u "$TMP_CATEGORIES.ns" | awk -F: '
    {
      ns[$1] = ns[$1] "  - " $2 "\n"
    }
    END {
      for (n in ns) {
        print n ":"
        printf "%s", ns[n]
      }
    }
  '
} > "$FINAL_CATEGORIES"

echo "🎉 Categories written to $FINAL_CATEGORIES"
