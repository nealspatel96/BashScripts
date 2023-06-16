#!/bin/bash

echo -e "\033[8;50;140t"

curl -s wttr.in/moon
echo ""
sleep 1
curl -s wttr.in

echo ""
echo -e "\e[35m Press any key to exit script...\e[0m"
read -s -n 1 key
exit