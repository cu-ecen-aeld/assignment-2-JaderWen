#!/bin/sh
# writer.sh for assignment 1
# Author: JaderWen

if [ $# -eq 2 ]
then
  WRITEFILE=$1
  if [ -n $2 ]
  then
    WRITESTR=$2
  else
    echo "$2 is not a valid string"
    exit 1
  fi
else
  echo "Please pass exactly 2 arguments"
  exit 1
fi

echo $WRITESTR > $WRITEFILE
if [ $? -ne 0 ]
then
  echo "Cannot write $WRITESTR into $WRITEFILE: path not valid or write-protected"
  exit 1
fi
