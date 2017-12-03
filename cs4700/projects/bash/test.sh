#!/bin/bash
j=0
for i in {0..1000};
do
  j=$((j + i));
done
echo $j
exit
