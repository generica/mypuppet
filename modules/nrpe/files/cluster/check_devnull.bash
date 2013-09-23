#!/bin/bash

test -c /dev/null

if [ $? -eq 0 ]
then
	echo "OK /dev/null is fine"
	exit 0
else
	echo "ERROR /dev/null not a character device"
	exit 2
fi
