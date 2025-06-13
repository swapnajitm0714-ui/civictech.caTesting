#!/bin/bash

set -euo pipefail

TAG_DIR="tags"

# Clean previous
echo "🧹 Cleaning existing tag pages..."
rm -rf "$TAG_DIR"
mkdir -p "$TAG_DIR"

# Generate master /tags/index.md
echo "⚡ Generating /tags/index.md..."
cat > "$TAG_DIR/index.md" <<EOF
---
layout: tags
title: Tags
permalink: /tags/
---
EOF

# Generate namespace and tag pages
echo "⚡ Generating namespace and tag pages organized by namespace..."

for ns in $(yq e 'keys | .[]' _data/tags.yml); do
  mkdir -p "$TAG_DIR/$ns"
  
  cat > "$TAG_DIR/$ns/index.md" <<EOF
---
layout: "tag-namespace"
title: "$ns Tags"
namespace: "$ns"
permalink: /tags/$ns/
---
EOF

  yq e ".\"$ns\"[]" _data/tags.yml | sed 's/^- //' | while IFS= read -r tag; do
    slug=$(echo "$tag" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]+/-/g; s/^-//; s/-$//')
    mkdir -p "$TAG_DIR/$ns/$slug"
    cat > "$TAG_DIR/$ns/$slug/index.md" <<EOF
---
layout: tag
title: "$tag"
namespace: "$ns"
tag: "${tag}"
full_tag: "$ns/$tag"
permalink: /tags/$ns/$slug/
---
EOF
    echo "✅ Generated tag page: $ns/$slug"
  done
done

echo "🎉 All namespace and tag pages generated."
