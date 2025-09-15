#!/bin/bash

output="final/ejercicios/final-ejercicios.md"

mkdir -p final/ejercicios
cat /dev/null > "$output"

first=1

mapfile -t files < <(find . -type d -name ejercicios | sort | while read dir; do
  for file in "$dir"/*.md; do
    [ -e "$file" ] && echo "$file"
  done
done | sort)

total=${#files[@]}
count=0

for file in "${files[@]}"; do
  ((count++))
  if [[ "$(realpath "$file")" == "$(realpath "$output")" ]]; then
    continue
  fi
  if [[ $first -eq 1 ]]; then
    cat "$file" >> "$output"
    first=0
  else
    awk '
      BEGIN { skip=0; port=0 }
      /^---/ && skip==0 { skip=1; next }
      /^---/ && skip==1 { skip=2; next }
      skip<2 { next }
      /<!-- _paginate: skip -->/ { port=1; next }
      port==1 && /^---/ { port=0; next }
      port==1 { next }
      { print }
    ' "$file" >> "$output"
  fi
  if [[ $count -lt $total ]]; then
    echo -e "\n---\n" >> "$output"
  fi
done

echo "Archivos concatenados en $output"