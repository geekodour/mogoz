#!/usr/bin/env bash

set -euo pipefail

# TODO: make source repo env var
cp -r ~/projects/oss/quartz . # copy it from a repo
cp quartz_config/* quartz/
pushd quartz
rm -rf .git
rm -rf docs
popd
