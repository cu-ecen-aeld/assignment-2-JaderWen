#!/bin/sh
# finder.sh for assignment 1
# Author: JaderWen

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
  NUMMATCHED=0
  if [ -r $1 ]
  then
    NUMMATCHED=`grep -c $SEARCHSTR $1`
    NUMLINES=`expr $NUMLINES + $NUMMATCHED`
  fi
}

read_dir(){
  for entry in `ls $1`
  do
    if [ -d $1"/"$entry ]
    then
      read_dir $1"/"$entry
    else
      NUMFILES=`expr $NUMFILES + 1`
      read_match $1"/"$entry
    fi
  done
}

read_dir $FILESDIR
echo "The number of files are $NUMFILES and the number of matching lines are $NUMLINES"
