#!/bin/bash

echo ""

echo -e "\n start redis  \n"

sudo redis-server /etc/sentinel/5000.conf --sentinel

echo ""