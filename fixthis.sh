#!/bin/bash

check_working_directory () {
	if [[ $(echo "$PWD" | grep "mail") == "" ]]; then
		echo "Error! mot in mail directory!"
		exit 1
	fi
}

migrate_mail_directory () {
	FOLDER_OLD="$1"
	FOLDER_NEW="$2"

	for FOLDER in "$(find ./ -maxdepth 1 -type d -name "$FOLDER_OLD*" -printf '%f\n')"; do
		rsync -rpav "$FOLDER" "${FOLDER//$FOLDER_OLD/$FOLDER_NEW}"
		if [[ $? -eq 0 ]]; then 
			rm -rf "$FOLDER"
		fi
	done
}

check_working_directory

migrate_mail_directory ".Gesendete Objekte" ".Sent"
migrate_mail_directory ".Gesendete Elemente" ".Sent"
migrate_mail_directory ".Entw&APw-rfe" ".Drafts"
migrate_mail_directory ".Papierkorb" ".Trash"
migrate_mail_directory ".Spam" ".Junk"
