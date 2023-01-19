#!/bin/bash

sleep 10
cat ec2_ip.txt
curl -I http://$(cat ec2_ip.txt)/api/search?q=public | head -n 1 | cut -d " " -f 2 > result.txt
wait
curl -I http://$(cat ec2_ip.txt)/api/search?q=city   | head -n 1 | cut -d " " -f 2 >> result.txt
wait
curl -I http://$(cat ec2_ip.txt)/api/search?q=time   | head -n 1 | cut -d " " -f 2 >> result.txt
wait
curl -I http://$(cat ec2_ip.txt)/api/search?q=sleep   | head -n 1 | cut -d " " -f 2 >> result.txt
wait
curl -I http://$(cat ec2_ip.txt)  | head -n 1 | cut -d " " -f 2 >> result.txt
wait

check=0
check=$(cat result.txt | grep 200 | wc -l)
if [  ${check} != 5 ] 
then
    echo "tests faild"
    exit 1
fi
