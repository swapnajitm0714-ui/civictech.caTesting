#!/bin/bash

set -euo pipefail

echo "🔍 Scanning archives for tags..."

ARCHIVES_DIR="archives"
TMP_TAGS=$(mktemp)
FINAL_TAGS=$(mktemp)

cleanup() {
  rm -f "$TMP_TAGS" "$FINAL_TAGS"
}
trap cleanup EXIT

# Step 1: Extract all tags into TMP_TAGS
find "$ARCHIVES_DIR" -type f -name "*.md" -print0 | while IFS= read -r -d '' file; do
  echo "📄 Checking $file"

  # Extract ONLY the YAML front matter between --- ---
  FRONTMATTER=$(awk '
    BEGIN { inside=0 }
    /^---$/ { inside = (inside==0)?1:0; next }
    inside { print }
  ' "$file")

  # If no frontmatter, skip
  if [ -z "$FRONTMATTER" ]; then
    echo "⚠️ No front matter found in $file, skipping."
    continue
  fi

  # Check if frontmatter is valid YAML before processing
  if echo "$FRONTMATTER" | yq e '.' >/dev/null 2>&1; then
    tags=$(echo "$FRONTMATTER" | yq e '.tags' 2>/dev/null || echo "")

    if [ -n "$tags" ] && [ "$tags" != "null" ]; then
      echo "$FRONTMATTER" | yq e '.tags[]' 2>/dev/null | while IFS= read -r tag; do
        [ -z "$tag" ] && continue
        echo "$tag" >> "$TMP_TAGS"
      done
    fi
  else
    echo "⚠️ Skipping invalid YAML front matter in $file"
  fi
done

# Step 2: Validate that some tags were found
if [ ! -s "$TMP_TAGS" ]; then
  echo "⚠️ No tags found. Exiting."
  exit 1
fi

# Step 3: Show how many tags we collected
tag_count=$(wc -l < "$TMP_TAGS" | tr -d ' ')
echo "✅ Found $tag_count raw tags."

# Step 4: Build clean _data/tags.yml
echo "{}" > "$FINAL_TAGS"

sort -u "$TMP_TAGS" | while IFS= read -r tag; do
  [ -z "$tag" ] && continue

  if [[ "$tag" != */* ]]; then
    echo "⚠️ Skipping malformed tag: $tag"
    continue
  fi

  ns="${tag%%/*}"
  value="${tag#*/}"

  # Update the YAML structure
  yq -i eval ".\"$ns\" += [\"$value\"] | .\"$ns\" = (.\"$ns\" | unique | sort)" "$FINAL_TAGS"
done

# Step 5: Finalize _data/tags.yml
SORTED_FINAL=$(mktemp)
yq eval 'to_entries | sort_by(.key) | from_entries' "$FINAL_TAGS" > "_data/tags.yml"

echo "🎉 Tags updated successfully in _data/tags.yml."
