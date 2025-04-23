#!/bin/zsh

set -euo pipefail

ARCHIVES_DIR="archives"
TMP_TAGS=$(mktemp)
FINAL_TAGS=$(mktemp)

echo "{}" > "$FINAL_TAGS"

# Extract all tags from markdown files under archives collections
for file in $(find "$ARCHIVES_DIR" -type f -name "*.md"); do
  # Pull each tag using yq and append to list
  yq --front-matter=process '.tags[]' "$file" 2>/dev/null >> "$TMP_TAGS" || true
done

# Sort and deduplicate tags
sort -u "$TMP_TAGS" | while read -r tag; do
  # Skip empty lines
  [[ -z "$tag" ]] && continue

  # Parse namespace and value
  ns="${tag%%/*}"
  value="${tag#*/}"

  # Use yq with eval mode (handles dynamic paths cleanly)
  yq -i eval ".\"${ns}\" += [\"${value}\"] | .\"${ns}\" = (.\"${ns}\" | unique | sort)" "$FINAL_TAGS"
done

# Write final result
mv "$FINAL_TAGS" "_data/tags.yml"
echo "✅ _data/tags.yml updated."

# Cleanup
rm "$TMP_TAGS"
