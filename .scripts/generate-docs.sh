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

