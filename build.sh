#!/bin/bash

<<<<<<< HEAD
files=$($(find blog/ -name "*.md"))
echo $files
#marked
=======
if [ -z $1 ]; then
  echo "Usage: $0 [-t <template.html>] <md-src> <build-dst>"
  echo "Options:"
  echo "  -t template.html  Specify a template HTML file (where your navbar is etc)"
  echo "  <md-src>          Directory of markdown files"
  echo "  <build-dst>       Destination of built files"
  echo -e "\nExample:"
  echo "  $0 -t template.php markdown/ blog/"
fi

files=$(ls "$1" | grep "\.md")
echo $files
marked
>>>>>>> 101d58e (Continue)
