#!/usr/bin/env bash

set -euo pipefail

pushd quartz
npx quartz build -d ../../content -o ../public --serve
cp -r ../../static/* ../public
popd
