#!/bin/bash

echo ""

echo -e "\nbuild docker redis image\n"
sudo docker build -t huanglin/rediscluster:3.2.8 .

echo ""