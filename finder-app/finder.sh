#!/bin/sh
# finder.sh for assignment 1
# Author: JaderWen

set -u
set -e

NUMFILES=0
NUMLINES=0

if [ $# -eq 2 ]
then
  if [ -d $1 ]
  then
    FILESDIR=$1
  else
    echo "$1 is not a directory"
    exit 1
  fi
  if [ -n $2 ]
  then
    SEARCHSTR=$2
  else
    echo "$2 is not a valid string"
    exit 1
  fi
else
  echo "Please pass exactly 2 arguments"
  exit 1
fi

read_match(){
  if [ -r $1 ]
  then
    NUMLINES=$(($NUMLINES + $(grep -c $SEARCHSTR $1)))
  fi
}

read_dir(){
  for entry in `ls $1`
  do
    if [ -d $1"/"$entry ]
    then
      read_dir $1"/"$entry
    else
      NUMFILES=$(($NUMFILES + 1))
      read_match $1"/"$entry
    fi
  done
}

read_dir $FILESDIR
echo "The number of files are $NUMFILES and the number of matching lines are $NUMLINES"
