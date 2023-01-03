#!/bin/bash
#
# a bash script I use for gopro and drone videos housekeeping to work in kdenlive proxy files
# my notebook has SSD (fast, but small), while video files are on extHD (big, but slow)
# kdenlive supports gopro LRV as proxy, but it takes forever working on extHD
# 
# this script gets rid of unecessary files, move LRV to SSD and rename drone files
# to speed up things in kdenlive.
#
# confirmation messages are in Portuguese. Translate as desired.
#
#confirm target directory
if [[ $# -eq 0 ]] ; then
    echo 'Informe diretorio de trabalho'
    exit 1
else
    #confirm
    echo "Pasta para faxina de vídeos: " $1
    read -p "Seguir (y/n): "  -n 1 -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]
        then
            echo ""
            exit 1
        else
            if [[ -d "$1" ]]
            then
               dir="${1%/}"
            fi
        fi
fi

#remove THM
rm $dir/*.THM

#rename drone files
for f in $dir/FI* ; do  mv -v $f $dir/GX-`basename -- $f`; done

#link LRV fm SSD to extHD
for f in $dir/*.LRV ; do
    mv -v $f ~/Vídeos/proxy
    ln -sv ~/Vídeos/proxy/`basename -- $f` $f ;
done
