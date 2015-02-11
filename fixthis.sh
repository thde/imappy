#!/bin/bash

check_working_directory () {
	if [[ $(basename "$PWD") !=  "mail" ]]; then
		echo "Error! mot in mail directory!"
		exit 1
	fi
}

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

check_working_directory
migrate_folder ".Gesendete Objekte" ".Sent"

