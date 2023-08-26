#!/usr/bin/env bash

set -euo pipefail

pushd quartz
npx quartz build -d ../../content -o ../public
cp -r ../../static/* ../public
popd
