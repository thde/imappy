#!/bin/bash

#############################################################################
# This script will merge all IMAP folders into Sent, Drafts, Trash and Junk #
#############################################################################
#
# If you're customers mail clients created lots of folders
# for the same purpose, use this script to clean them up.
#
#

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

        find ./ -maxdepth 1 -type d -name "$FOLDER_OLD*" | while read -r file ; do

                echo "---------------"
                echo "$file"
                echo "---------------"
                FOLDER_BASE="$(basename "$file")"
                TARGET_BASE="${FOLDER_BASE//$FOLDER_OLD/$FOLDER_NEW}"
		echo $FOLDER_BASE
                echo $TARGET_BASE
                        
                if [ -d "$FOLDER_BASE" ]; then
                        rsync -rav "$FOLDER_BASE/" "$TARGET_BASE"
                        rm -rf "$FOLDER_BASE"
                        chown "$USER":"$USER" "$TARGET_BASE"
                        chmod 751 "$TARGET_BASE"
                fi
        done
}

check_working_directory

migrate_mail_directory ".Gesendete Objekte" ".Sent"
migrate_mail_directory ".Gesendete Elemente" ".Sent"
migrate_mail_directory ".Sent Messages" ".Sent"
migrate_mail_directory ".sent-mail" ".Sent"
migrate_mail_directory ".Entw&APw-rfe" ".Drafts"
migrate_mail_directory ".Papierkorb" ".Trash"
migrate_mail_directory ".Deleted Messages" ".Trash"
migrate_mail_directory ".Gel&APY-schte Elemente" ".Trash"
migrate_mail_directory ".Spam" ".Junk"
migrate_mail_directory ".spam" ".Junk"
migrate_mail_directory ".Junk-E-Mail" ".Junk"
