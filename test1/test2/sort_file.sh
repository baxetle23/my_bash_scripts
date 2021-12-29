#!/bin/bash

#create array files and possible dates

echo "SCRIPT SORT FILE OSCIL STARTS WORK"

ROOT_DIR=$1

const_ext1="cfg" #const extencion files which moveing
const_ext2="dat" #const extencion files which moveing

cd $ROOT_DIR

for each in * #name file - may be use regular expressions
    do
        extension="${each##*.}";
        if [[ $extension == $const_ext1 || $extension == $const_ext2 ]]; then
            date_file=$(date +%d-%m-%Y -r "$each");   #get data create file
            ARRAY_DATES+=( $date_file );
            ARRAY_FILES+=( $each );
        fi
    done


DATES=$(printf "%s\n" "${ARRAY_DATES[@]}" | sort -u);

for date in ${DATES[@]}; do
    if [ ! -d "$date" ]; then #check for directory existence
        mkdir "$date"
    fi
done

for i in  ${ARRAY_FILES[@]}; do
    dest=$(date +%d-%m-%Y -r "$i") 
    mv $i $dest/$i
done
