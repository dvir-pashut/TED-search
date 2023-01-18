#!/bin/bash

curl -I http://13.39.80.136/api/search?q=public | head -n 1 | cut -d " " -f 2 > result.txt
wait
curl -I http://13.39.80.136/api/search?q=city   | head -n 1 | cut -d " " -f 2 >> result.txt
wait
curl -I http://13.39.80.136/api/search?q=time   | head -n 1 | cut -d " " -f 2 >> result.txt
wait
curl -I http://13.39.80.136/api/search?q=sleep   | head -n 1 | cut -d " " -f 2 >> result.txt
wait
curl -I http://13.39.80.136/api/search?q=sleep   | head -n 1 | cut -d " " -f 2 >> result.txt
wait

check=0
check=$(cat result.txt | grep 200 | wc -l)
if [  ${check} != 5 ] 
then
    echo "tests faild"
    exit 1
fi
