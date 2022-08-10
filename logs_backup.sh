#!/bin/sh

set -e
#set -o pipefail

DIR=../croupier/resources/logs/

elegible_to_archive () {
  currentDate=$(date +"%Y%m")
  currentYear="${currentDate:0:4}"
  currentMonth="${currentDate:4:2}"

  if [[ $year == $currentYear && $month < $currentMonth ]]; then
      return
  elif [[ $year -lt $currentYear ]]; then
    return
  else
    return 1
  fi
}

move_log_files () {
	log=$file
	year="${log:27:4}"
	month="${log:31:2}"
	
	if elegible_to_archive "$year" "$month"; then
    if [[ ! -d "$DIR$year$month" ]]; then
      echo "Directory $year$month does not exist. Will be created."
      mkdir $DIR$year$month
    fi
    mv $log $DIR$year$month
	fi
}

zip_past_log_collections () {
	echo "Start directory $f compression"

  echo Zipping...
  zipFileName=${f:27:6}
  zip -r -j $DIR$zipFileName.zip $f
#	fi

	[[ -f ${f%/}.zip ]] && rm -rf $f
}


echo "Start log files backup.."

python ./log_rename.py
#version=$(python --version 2>&1 | perl -pe 's/python *//i')
#if [ $version ]; then
#    echo "Normalize log file names."
#else
#    echo "python is not installed"
#    exit 1
#fi

for f in $DIR*-output.log; do
	file=$f
	[ -f "$file" ] || break
	[ ${file##*.} = "log" ] && move_log_files "$file"
done

for f in $DIR*/; do
	[[ -d $f ]] && zip_past_log_collections "$f"
done

zip_files=$(find $DIR -type f -name "*.zip")

if [ "$zip_files" ]; then
  rclone move --no-traverse $DIR --include "*.zip" gdrive:croupier/logs_backup -P
fi
