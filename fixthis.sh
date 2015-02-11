#!/bin/bash

migrate_folder () {

	FOLDER_OLD="$1"
	FOLDER_NEW="$2"


	for FOLDER in "$(find ./ -maxdepth 1 -type d -name "$FOLDER_OLD*" -printf '%f\n')"; do
		FOLDER_TARGET="${FOLDER//$FOLDER_OLD/$FOLDER_NEW}"
		rsync -rav "$FOLDER" "$FOLDER_TARGET"
	done
}

mkdir "test"
mkdir "test/.Gesendete Objekte"
mkdir "test/.Gesendete Objekte.Test"
mkdir "test/.Sent"
cd "test"


migrate_folder ".Gesendete Objekte" ".Sent"

