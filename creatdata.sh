#!/bin/sh
for ((i=1;i<=100;i++))
do
let phone=13000000000+${i}
let score=${RANDOM}
echo "${i}|s_${i}|${phone}|${score}" >>1.txt
done