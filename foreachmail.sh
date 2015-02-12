#!/bin/bash

CURRENT_DIR="$PWD"

find ./ -maxdepth 1 -mindepth 1 -type d -name "*\.*" | while read -r file ; do

	echo "---------------"
	echo "$file"
	echo "---------------"
	
	cd "$file"
	curl https://raw.githubusercontent.com/thde/imap-fix/master/fixthis.sh -s | bash
	cd "$CURRENT_DIR"

done
