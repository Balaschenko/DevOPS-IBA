#!/bin/bash

echo -n "Vvedite file name: "
read FILE

if [ ! -f "$FILE" ]
then
	echo "File \"$FILE\" doesn't exist"
	exit 1
fi

if grep -w error $FILE  1>/dev/null
then
	rm -f $FILE
	echo "File \"$FILE\" udalen"
else
	echo "Word "error" doesn't appear in file \"$FILE\""
fi

