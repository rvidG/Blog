#!/bin/bash

function usage() {
  echo "Usage: $0 [-t <template.html>] [-e <file extension>] <md-src> <build-dst>"
  echo "Options:"
  echo "  -t template.html     Specify a template HTML file (where your navbar is etc)"
  echo "  -e <file extension>  File extension/postfix to use"
  echo "  -h                   Show this help message"
  echo "  <md-src>             Directory of markdown files"
  echo "  <build-dst>          Destination of built files"
  echo -e "\nExample:"
  echo "  $0 -t template.php -e ".php" markdown/ blog/"
  exit 0
}

while getopts 'teh' OPTION; do
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
  esac
done

if [ -z $2 ]; then
  usage
else
  files=$(ls "$1" | grep "\.md")
  echo $files
  marked "$(cat $files)"
fi
