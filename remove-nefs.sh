#!/bin/bash

# I use this script to automatically remove .nef files once I remove the corresponding .jpg files.
# TODO:
# - option for dry run
# - better argument checks

# chekc if arguments was passed
if [ $# -lt 4 ] ; then
  echo "Missing arguments. Provide directory to check, extension to keep and extension to delete";
  exit 1;
fi

# save s in variable
A_DIR=$1
A_KEEP_EXT=$2
A_DEL_EXT=$3
A_DRY=$4

# check if a directory was passed as argument
if [ ! -d "${A_DIR}" ] ; then 
  echo "${A_DIR} is not a directory";
  exit 1;
fi

CHECK_FOR="${A_DIR}"/*."${A_DEL_EXT}"

for f in ${CHECK_FOR} ; do

  if [[ "$f" != "./"* ]]; then
    FILENAME="${f%.*}"
    CHECK_FILE="${FILENAME}"."${A_KEEP_EXT}"
    DEL_FILE="${FILENAME}"."${A_DEL_EXT}"

    if [ -f "$CHECK_FILE" ] ; then
      echo "$CHECK_FILE" exists. Keeping ${DEL_FILE}
    else
      echo "$CHECK_FILE" doesn\'t exist. Deleting ${DEL_FILE}
      
			if [ ! ${A_DRY} == "dry" ]; then 
				echo "DELETING"
				rm -fv ${DEL_FILE}
			fi
    fi
  fi

done;
