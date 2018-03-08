#!/bin/bash

set -e

version=$(grep version package.json | cut -d: -f2 | cut -d\" -f2)

rm -f SHA256SUMS
sha256sum *.py pkg/*.py LICENSE > SHA256SUMS
rm -rf lib
mkdir lib
pip3 install -r requirements.txt -t lib --no-binary lifxlan --prefix ""

rm -rf *.tgz package
mkdir package
cp -r lib pkg LICENSE SHA256SUMS package.json *.py package/
find package -type f -name '*.pyc' -delete
find package -type d -empty -delete
tar czf "lifx-adapter-${version}.tgz" package
