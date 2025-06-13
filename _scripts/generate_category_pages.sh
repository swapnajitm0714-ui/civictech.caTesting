#!/bin/bash
set -euo pipefail

CATEGORY_DIR="categories"
YAML_FILE="_data/categories.yml"

echo "🧹 Cleaning existing category pages..."
rm -rf "$CATEGORY_DIR"
mkdir -p "$CATEGORY_DIR"

echo "⚡ Generating /categories/index.md..."
cat > "$CATEGORY_DIR/index.md" <<EOF
---
layout: categories
title: Categories
permalink: /categories/
---
EOF

echo "⚡ Generating namespaced category pages..."

for ns in $(yq e 'keys | .[]' "$YAML_FILE"); do
  mkdir -p "$CATEGORY_DIR/$ns"

  # Namespace index page
  cat > "$CATEGORY_DIR/$ns/index.md" <<EOF
---
layout: "category-namespace"
title: "$ns Categories"
namespace: "$ns"
permalink: /categories/$ns/
---
EOF

  # Individual category pages
  yq e ".\"$ns\"[]" "$YAML_FILE" | sed 's/^- //' | while IFS= read -r cat; do
    slug=$(echo "$cat" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]+/-/g; s/^-//; s/-$//')
    mkdir -p "$CATEGORY_DIR/$ns/$slug"
    cat > "$CATEGORY_DIR/$ns/$slug/index.md" <<EOF
---
layout: category
title: "$cat"
namespace: "$ns"
category: "$ns/$cat"
permalink: /categories/$ns/$slug/
---
EOF
    echo "✅ Generated category: $ns/$slug"
  done
done

echo "🎉 All categories generated."
