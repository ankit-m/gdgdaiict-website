#!/bin/bash

maxx=0
maxy=0

# find largest dimension
for file in *.jpg ; do
  dim=$(identify "$file" | awk '{ print $3 }')
  xdim=$(echo $dim | cut -f1 -dx)
  ydim=$(echo $dim | cut -f2 -dx)
  if [ $xdim -gt $maxx ] ; then
    maxx=$xdim
  fi
  if [ $ydim -gt $maxy ] ; then
    maxy=$ydim
  fi
done

mkdir bordered

# resize and store new images in new folder
for file in *.jpg ; do
  dim=$(identify "$file" | awk '{ print $3 }')
  xdim=$(echo $dim | cut -f1 -dx)
  ydim=$(echo $dim | cut -f2 -dx)

  xborder=$(( ($maxx - $xdim ) / 2 ))
  yborder=$(( ($maxy - $ydim ) / 2 ))

  convert "$file" -bordercolor black -border ${xborder}x${yborder} "bordered/$file"

done
