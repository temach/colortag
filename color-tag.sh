#!/bin/bash

# Requires: 
#   realpath
#   convert and composite from imagemagic package
#   uses gvfs-set-attribute
# 


# Check for two arguments 
# Check if first arg is help
if [[ "$#" -ne 2 || "$1" =~ '^[hH]elp' ]]
then
    echo -e "\n\n\t Usage: color-tag <color> <filepath>" 
    echo -e "\t <color> can be anything in http://www.imagemagick.org/script/color.php" 
    echo -e "\t <filepath> is relative or absolute path to your file"
    echo -e "\t Remember to hit F5 key to refresh nautilus so it will display the changes. \n\n"
    echo -e "\t"
    exit 1
fi


# Introduction
echo -e "  Running program to change color tag for file."
echo -e "  Remember to press F5 key to refresh nautilus to see the changes.\n"

color="$1"
filepath=$( realpath "$2" )
if [ $? != 0 ] 
then 
    echo "" 
    exit 0 
fi

echo "Will change tag of ${filepath} to ${color}"





# default variables
progname="colortag"
tmpformat="${progname}.tmpfile_XXXXXXXXXXXX"
progdir="${HOME}/.${progname}/"
cachedir="${HOME}/.${progname}/cache/"
datadir="${HOME}/.${progname}/data/"
tmpdir="${HOME}/.${progname}/tmp/"


if [ ! -d "$progdir" -o ! -d "$cachedir" -o ! -d "$datadir" -o ! -d "$tmpdir" ]
then
    echo "Will make program directory $progdir because it does not exist yet."
    mkdir -p "$progdir"
    mkdir -p "$cachedir"
    mkdir -p "$datadir"
    mkdir -p "$tmpdir"
    
    if [ $? != 0 ]
    then
        echo "Could not make directory $progdir Run with sudo maybe?"
        exit 1
    fi
fi





# create path to the final result
filename=$( basename "$filepath" )
extension="${filename##*.}"
resultpath="${cachedir}${color}_${extension}.png"
echo "will cache resulting image to here: $resultpath"



# check if this color with this type already exists
if [ -f "$resultpath" ]
then
    echo "Will use precached image."
    gvfs-set-attribute -t "string" "$filepath" "metadata::custom-icon" "file://$resultpath"
    if [ $? != 0 ]
    then
        echo "Could not change icon preview for file."
        exit 1
    else 
        exit 0
    fi
else
    echo "Will generate new .png and store it into cache."
fi




# make the color image and check for error
colorimg="${cachedir}${color}.png"
echo "Will create color image here: $colorimg"
convert -size "70x70" "canvas:$color" "$colorimg"
if [ $? != 0 ]
then
    echo "Could not make color overlay. Check color spelling? You gave me: _${color}_  (underscored for clarity)"
    exit 1
fi





# Use the file preview and overlay it with color
fileimg="${datadir}${extension}.png"
fallbackimg="${datadir}txt.png"

# preview not found and no fallback
if [ ! -f "$fileimg" -a ! -f "$fallbackimg" ]
then 
    echo "Could not find preview file: $fileimg"
    echo -e "\t fallback file $fallbackimg not provided, so quitting."
    exit 1
fi

# preview not found but we have a fall back
if [ ! -f "$fileimg" ]
then
    echo "Will use generic plain text file preview $fallbackimg"
    echo -e "\t because file $fileimg was not found"
    echo -e "\t you need to create it. Dimensions are 70x70 pixels, in .png format" 
    fileimg=$fallbackimg
fi

# preview found
echo "Will use $fileimg as file preview."






# Overlay the preview image with color. The -blend affects transparency.
composite -blend "20" "$colorimg" "$fileimg" "$resultpath"

# make the image darker and sharpen it.
convert "$resultpath" -level 50%,100% -sharpen 0x2.0 "$resultpath"

if [ $? != 0 ]
then
    echo "Could not create a resulting file icon."
    exit 1
fi




# change the preview image for the file
echo "Will change file's preview icon."
gvfs-set-attribute -t "string" "$filepath" "metadata::custom-icon" "file://$resultpath"
if [ $? != 0 ]
then
    echo "Could not change icon preview for file."
    exit 1
fi


exit 0



