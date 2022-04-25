#!/bin/bash

# ./push.sh
# ./push.sh "fw7 3.4.2"
git add .
git add -u
if [ $# -gt 0 ]; then
	git commit -m "$1"
else
	git commit -m "`date`"
fi
git push origin
