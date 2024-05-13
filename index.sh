#!/bin/bash

PHONEBOOK_FILE="phonebook.txt"

# Create phonebook file if it doesn't exist
touch $PHONEBOOK_FILE

case $1 in
    new)
        echo "$2 $3" >> $PHONEBOOK_FILE
        echo "Entry added: $2 $3"
        ;;
    list)
        if [ -s $PHONEBOOK_FILE ]; then
            cat $PHONEBOOK_FILE
        else
            echo "Phonebook is empty"
        fi
        ;;
    remove)
        if grep -q "^$2 " $PHONEBOOK_FILE; then
            grep -v "^$2 " $PHONEBOOK_FILE > temp && mv temp $PHONEBOOK_FILE
            echo "Entries removed for $2"
        else
            echo "$2 not found in phonebook"
        fi
        ;;
    clear)
        > $PHONEBOOK_FILE
        echo "Phonebook cleared"
        ;;
    lookup)
        if grep -q "^$2 " $PHONEBOOK_FILE; then
            echo "Phone number(s) for $2:"
            grep "^$2 " $PHONEBOOK_FILE | cut -d ' ' -f 2-
        else
            echo "$2 not found in phonebook"
        fi
        ;;
    *)
        echo "Usage: $0 {new|list|remove|clear|lookup}"
        exit 1
        ;;
esac