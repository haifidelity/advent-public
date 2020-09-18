#!/bin/bash

set -e

REAL_ROOM_IDS=()

function room {
 local room=$1
 room_hash=`echo $room | egrep -o '[^(?\[)]+\]' | sed 's/\]//g'`
 room_sector_id=`echo $room | egrep -o '[0-9]+'`
 room_eval=`echo $room | egrep -o '^[^(?[:digit:])]+' | sed 's/-//g ; s/ //g' | grep -o . | sort | uniq -c | sort -k1n -k2r | tail -5 | awk '{print $2}' | sed '1!G;h;$!d' | paste -s -d ""`

 if [[ "${room_hash}" == "${room_eval}" ]] ; then
   REAL_ROOM_IDS+=("${room_sector_id}")
 fi
}

function main {
  while read -r line ; do
    room $line
  done < advent.txt

  for room in ${REAL_ROOM_IDS[@]} ; do
    let TOTAL+=${room}
  done
  echo $TOTAL
}

main
