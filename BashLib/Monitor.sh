#!/bin/bash


function monitor
{
   tput civis #make cursor invisible while running this loop
   clear
   inc=0
   while (true)
   do
      if [ $inc == '0' ]
      then
         tput cup $(tput lines) 0
         echo -e "\e[1;31m [q] quit\e[0m"
         inc=1
      else
         #run the function argument that gets called with watch
         $1
      fi
      read -t 0.05 -s -N 1 quitMonitor
      if [ -z $quitMonitor ]
      then 
         sleep 0.0000001
      elif [ $quitMonitor == 'q' ]
      then
         clear
         tput cnorm # normal mode: make the cursor show up again
         break
      else
         clear
      fi
      #clear only stuff thats been outputted instead of entire terminal to avoid flicker
      tput cup 0 0
   done
}
