#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

app=$1
change_file=$2
bump_type=$(cat $change_file | yq .bump)

pushd apps/$1 > /dev/null
# https://github.com/maykonlf/semver-cli
new_version=$(semver up $bump_type)
echo $new_version > VERSION
popd > /dev/null
