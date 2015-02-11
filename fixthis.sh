#!/bin/bash

migrate_folder () {
	FOLDER_OLD="$1"
	FOLDER_NEW="$2"

	for FOLDER in "$(find ./ -maxdepth 1 -type d -name "$FOLDER_OLD*" -printf '%f\n')"; do
		rsync -rav "$FOLDER" "${FOLDER//$FOLDER_OLD/$FOLDER_NEW}"
		if [[ $? -eq 0 ]]; then 
			rm -rf "$FOLDER"
		fi
	done
}

mkdir "test"
mkdir "test/.Gesendete Objekte"
mkdir "test/.Gesendete Objekte.Test"
mkdir "test/.Sent"
cd "test"


migrate_folder ".Gesendete Objekte" ".Sent"

