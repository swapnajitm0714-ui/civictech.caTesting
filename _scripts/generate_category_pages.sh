#!/bin/bash
set -euo pipefail

CATEGORY_DIR="categories"
YAML_FILE="_data/categories.yml"

# Clean previous
echo "🧹 Cleaning existing category pages..."
rm -rf "$CATEGORY_DIR"
mkdir -p "$CATEGORY_DIR"

# Create master index
echo "⚡ Generating /categories/index.md..."
cat > "$CATEGORY_DIR/index.md" <<EOF
---
layout: categories
title: Categories
permalink: /categories/
---
EOF

# Generate each category page
yq e '.categories[]' "$YAML_FILE" | while IFS= read -r category; do
  slug=$(echo "$category" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]+/-/g; s/^-//; s/-$//')
  mkdir -p "$CATEGORY_DIR/$slug"
  cat > "$CATEGORY_DIR/$slug/index.md" <<EOF
---
layout: category
title: "$category"
category: "$category"
permalink: /categories/$slug/
---
EOF
  echo "✅ Generated category page: $category → /categories/$slug/"
done

echo "🎉 All category pages generated."
