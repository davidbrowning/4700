#!/bin/bash

Y=$(date +%Y)
if [ -z $(ls $Y) ]; then
  mkdir $Y
fi

cd $Y
m=$(date +%m)
if [ -z $(ls $m) ]; then
  mkdir $m
fi

cd $m
d=$(date +%d)
if [ -z $(ls $d) ]; then
  mkdir $d
fi

cd $d
> notes.txt
vim notes.txt
