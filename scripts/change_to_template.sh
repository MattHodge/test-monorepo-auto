#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

app_name=$1
change_file=$2

# https://github.com/bluebrown/go-template-cli
cat $2 | tpl --file scripts/changelog.tpl --decoder yaml > apps/$1/CHANGELOG.md
