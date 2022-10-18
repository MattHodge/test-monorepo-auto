#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'


app_name=$1
bump_type=$2

filename="apps/${app_name}/.changes/$(date +%s).yaml"

echo $filename

cat > $filename << EOF
---
app: ${app_name}
bump: $2
changes:
  added:
    - CHANGE ME
  changed:
    - CHANGE ME
    - |
      Multi
      Line
      Stuff
EOF
