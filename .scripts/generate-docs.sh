#! /bin/bash

groups=$(ls -d */)

# loop groups
for groupPath in ${groups[@]}; do
  groupName=${groupPath%/}
  
  # loop modules
  modules=$(ls -d ${groupPath}*/)

  for modulePath in ${modules[@]}; do
    moduleName=${modulePath%/}
    
    terraform-docs markdown table --output-file README.md --output-mode inject $modulePath
  done
done

# move files to docs folder
rm -rf docs
mkdir docs

cp lib/README.md docs/README.md

for source_file_path in ./lib/**/*.md; do
  destination_file_path="docs/${source_file_path#"./lib/"}"
  echo $source_file_path
  echo $destination_file_path

  mkdir -p "$(dirname "$destination_file_path")"
  cp "$source_file_path" "$destination_file_path"
done