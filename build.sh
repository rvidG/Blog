#!/bin/bash

function usage() {
  echo "Usage: $0 [-t <template.html>] [-e <file extension>] <md-src> <build-dst>"
  echo "Options:"
  echo "  -t template.html     Specify a template HTML file (where your navbar is etc)"
  echo "  -e <file extension>  File extension/postfix to use (Default: .html)"
  echo "  -h                   Show this help message"
  echo "  <md-src>             Directory of markdown files"
  echo "  <build-dst>          Destination of built files"
  echo -e "\nExample:"
  echo "  $0 -t template.html -e \".html\" markdown/ blog/"
  exit 0
}

ext=".html"

while getopts 't:e:h' OPTION; do
  case "$OPTION" in
  t)
    template="$OPTARG"
    ;;
  e)
    ext="$OPTARG"
    ;;
  h)
    usage
    ;;
  ?)
    usage
    ;;
  esac
done

shift $((OPTIND - 1))

if [ $# -ne 2 ]; then
  usage
fi

md_src="$1"
build_dst="$2"

mkdir -p "$build_dst"

for filepath in "$md_src"/*.md; do
  [ -f "$filepath" ] || continue

  export FILENAME=$(basename "$filepath" .md)
  export CONTENT=$(marked "$filepath")

  output_file="$build_dst/$FILENAME$ext"

  if [ -n "$template" ]; then
    envsubst <"$template" >"$output_file"
  else
    echo "$CONTENT" >"$output_file"
  fi
done
