#!/bin/bash

check_working_directory () {
        if [[ $(echo "$PWD" | grep "mail") == "" ]]; then
                echo "Error! mot in mail directory!"
                exit 1
        fi
}

migrate_mail_directory () {
        USER=$(stat -c '%U' ./)
        FOLDER_OLD="$1"
        FOLDER_NEW="$2"

        for FOLDER in "$(find ./ -maxdepth 1 -type d -name "$FOLDER_OLD*")"; do
                FOLDER_BASE="$(basename "$FOLDER")"
                TARGET_BASE="${FOLDER_BASE//$FOLDER_OLD/$FOLDER_NEW}"
                        
                if [ -d "$FOLDER_BASE" ]; then
                        rsync -rav "$FOLDER_BASE" "$TARGET_BASE"
                        rm -rf "$FOLDER_BASE"
                        chown "$USER":"$USER" "$TARGET_BASE"
                        chmod 744 "$TARGET_BASE"
                fi
        done
}

check_working_directory

migrate_mail_directory ".Gesendete Objekte" ".Sent"
migrate_mail_directory ".Gesendete Elemente" ".Sent"
migrate_mail_directory ".Entw&APw-rfe" ".Drafts"
migrate_mail_directory ".Papierkorb" ".Trash"
migrate_mail_directory ".Spam" ".Junk"
