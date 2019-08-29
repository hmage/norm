#!/usr/bin/env bash

set -eE
set -o pipefail

cat >.travis.yml.new << EOF
language: minimal

env:
EOF
for i in `git ls packages/*`; do
    echo " - FORMULA=${i##*/}" >> .travis.yml.new
done

cat >>.travis.yml.new << 'EOF'

cache:
  directories:
    - testlogs/

script:
  - travis_wait 60 ./norm testall $FORMULA
EOF

mv .travis.yml.new .travis.yml
