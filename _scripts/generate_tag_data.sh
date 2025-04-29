#!/bin/bash
set -euo pipefail

echo "🔍 Scanning archives for tags..."

ARCHIVES_DIR="archives"
TMP_TAGS=$(mktemp)
FINAL_TAGS="_data/tags.yml"

cleanup() {
  rm -f "$TMP_TAGS"
}
trap cleanup EXIT

# Extract tags under the 'tags:' key
find "$ARCHIVES_DIR" -type f -name "*.md" -print0 | while IFS= read -r -d '' file; do
  echo "📄 Checking $file"

  awk '
    BEGIN { in_yaml=0; in_tags=0 }
    /^---$/ { in_yaml = !in_yaml; next }

    in_yaml {
      if ($0 ~ /^tags:/) {
        in_tags = 1
        next
      }

      if (in_tags) {
        if ($0 ~ /^[^[:space:]]/ || $0 ~ /^ *[a-zA-Z0-9_-]+:/) {
          # New key/value pair or end of tags block
          in_tags = 0
        } else if ($0 ~ /^ *- /) {
          gsub(/^ *- /, "", $0)
          print $0
        }
      }
    }
  ' "$file" >> "$TMP_TAGS"
done

# Validate
if [ ! -s "$TMP_TAGS" ]; then
  echo "⚠️ No tags found. Exiting."
  exit 1
fi

# Build clean _data/tags.yml
echo "{}" > "$FINAL_TAGS"
echo "🛠 Building tags.yml..."

sort -u "$TMP_TAGS" | while read -r tag; do
  [ -z "$tag" ] && continue

  if [[ "$tag" != */* ]]; then
    echo "⚠️ Skipping malformed tag: $tag"
    continue
  fi

  ns="${tag%%/*}"
  value="${tag#*/}"

  printf "%s\n" "$ns:$value" >> "$TMP_TAGS.ns"
done

# Write final YAML grouped by namespace
{
  echo ""
  sort -u "$TMP_TAGS.ns" | awk -F: '
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
} > "$FINAL_TAGS"

echo "🎉 Tags written to $FINAL_TAGS"
