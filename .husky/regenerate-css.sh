#!/bin/bash
set -eux

if git status -s | grep 'vector2022pp.scss$'; then
  fullPath=$(git status -s | grep '^M.\+vector2022pp.scss$' | sed -E 's/^M\s+//')
  filename=$(basename $fullPath)
  absoluteDir=$(cd $(dirname ${fullPath}) && pwd)
  absolutePath="$absoluteDir/$filename"
  sass $absolutePath ${absolutePath/scss/css}
  prettier --print-width 100 --write $absolutePath
  git add ${absolutePath/scss/css} ${absolutePath/scss/css}.map -f
fi

exit 0
