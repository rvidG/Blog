# Script based on "Bash - Parse Yaml Front Matter" by Jonas DOREL
# Link to original blogpost: https://jonasdorel.com/it/blog/bash-parse-yaml-front-matter/

if [[ $(\head -n 1 "$1") == "---" ]]; then
  # Case there might be a YAML Front Matter
  while IFS='' read -r line; do # IFS='' to keep whitespaces
    # Check end of YAML Front Matter
    (echo $line | grep -- '---' &>/dev/null) && yaml_front_matter_validated="true" && break

    yaml_front_matter="${yaml_front_matter}${line}\n"

  done < <(\tail -n +2 "$1") # Skip first line containing ---

  if [[ $yaml_front_matter_validated == "true" ]]; then
    # Case there is a YAML Front Matter
    echo "${yaml_front_matter}"
  else
    # Case there is NO VALID a YAML Front Matter
    return 1
  fi
else
  # Case there is NO YAML Front Matter
  return 1
fi
echo -e $yaml_front_matter | yq -r .project.name
