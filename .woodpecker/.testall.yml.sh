#!/usr/bin/env bash

set -eE
set -o pipefail

cat >.testall.yml.new <<'EOF'
workspace:
   base: /build
   path: norm

pipeline:
  ${FORMULA}:
    image: normdebian
    commands:
    - ./norm-testall ${FORMULA}
    volumes:
    - /var/cache/norm/testlogs:/build/norm/testlogs
    - /var/cache/norm/ccache:/root/.cache/ccache

depends_on:
- normdebian

matrix:
  FORMULA:
EOF
for i in `git ls ../packages/*`; do
    echo "  - ${i##*/}" >> .testall.yml.new
done

mv .testall.yml{.new,}
