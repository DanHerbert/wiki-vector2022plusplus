#!/bin/bash
set -eu

if git status -s | grep 'vector2022pp.scss$'; then
  relativeSassPath=$(git status -s | grep '^M.\+vector2022pp.scss$' | sed -E 's/^M\s+//')
  sassFilename=$(basename $relativeSassPath)
  absoluteSassDir=$(cd $(dirname ${relativeSassPath}) && pwd)
  absoluteSassPath="$absoluteSassDir/$sassFilename"
  absoluteCssPath="${absoluteSassPath/scss/css}"
  npx sass $absoluteSassPath $absoluteCssPath
  npx prettier --print-width 100 --write $absoluteCssPath
  git add $absoluteCssPath $absoluteCssPath.map -f
fi

exit 0
