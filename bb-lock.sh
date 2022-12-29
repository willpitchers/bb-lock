#!/bin/bash

## script to make zip archive backup of bash settings files, 
## conda config files, and user PATH against the possibility 
## of another Windows crash with WSL failure...
## Can also remind me of the Powershell command to write a 
## .tar image of the full WSL installation

if ! command -v zip &> /dev/null
then
    echo "zip could not be found"
    exit
fi

if ! command -v conda &> /dev/null
then
    echo "conda could not be found"
    exit
fi

opt_f=false
opt_i=false

usage() { echo "Usage: $0 [-s Save config ] \
[-f <directory> include folder ] \
[-i Print tar image command ]" 1>&2; exit 1; }

while getopts "sf:ih" o; do
    case "${o}" in
        s)
            export opt_s=true
            ;;
        f)
            export opt_f=${OPTARG}
            ;;
        i)
            export opt_i=true
            ;;
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done

if [[ ${opt_s} = true ]]
then
    mkdir bb_lock_tmp && cd bb_lock_tmp
    # export conda envs as ..yaml config files
    conda env list | cut -f 1 -d' ' | tail -n -3 | head -n -1 | \
        while read i
            do conda env export -n ${i} > ${i}.yml
        done
    
    echo ${PATH} > my_PATH.txt

    # zip up conda ..yamls and ~/.<xyz>rc files, $PATH & optional folders
    zip bb_locker_$(date +'%F').zip *yml ~/.* my_PATH.txt
    if [[ -d ${opt_f} ]]
    then
        # echo ${opt_f}
        zip -gr bb_locker_$(date +'%F').zip ${opt_f}
    fi

    cd ../ && mv bb_lock_tmp/*zip /mnt/c/wsl_backup/ && rm -rf bb_lock_tmp

elif [[ ${opt_i} = true ]]
# echo powershell one-liner to write tar img. of entire WSL
    then
        echo "copy & paste this into Powershell:
            wsl --shutdown
            wsl --export ubuntu c:\wsl_backup\Ubuntu_$(date +'%F').tar"
fi
