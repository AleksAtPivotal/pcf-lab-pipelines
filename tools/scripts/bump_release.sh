#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

vars=$(cat $DIR/../config.ini)

for var in $vars; do 
    k=""
    v=""
    k=$(echo $var | awk -F'=' '{print $1}')
    v=$(echo $var | awk -F'=' '{print $2}')
    export $k=$v
done

function params_test {
    case $2 in
    pks)
        echo "Updating PKS Versions. New PKS Version: $pks_version , new OpsMan version: $opsman_version"

        ;;
    pas)     
        echo "Updating PAS Versions.  New PAS Version: $pas_version , new OpsMan version: $opsman_version"
        ;;
    *)
        echo "ERROR"
        exit 1
    esac

    local files
    files=$(find $DIR/../../pipelines/$1 -name params.yaml.example)
    for file in $files; do
        cat $file | grep -i version 
        # write something to find replace the version
    done
}

params_test install-pks pks
#params_test install-pas-srt pas