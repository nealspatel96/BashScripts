#!/bin/bash

source ./BashLib/Monitor.sh

function currentTime
{
   echo -e "$(tput setaf 5 ; tput bold)"
   time printf "$(date +Date:' '%A,' '%B-%d-%Y%n$(date +%Z)' 'Time:' '%I:%M:%S' '%p)\n\n"
}

function utcTime
{
   echo -e "$(tput setaf 5 ; tput bold)"
   time printf "UTC Time: $(date -ud @$(date +%s))\n\n"
}

function epochTime
{
   echo -e "$(tput setaf 5 ; tput bold)"
   time printf "Seconds since Epoch[1/1/1970]: $(date +%s.%N)\n\n"
}

function displayAllTimeOptions
{
   echo -e "$(tput setaf 5 ; tput bold)"
   time printf "$(date +%Z' 'Time:' '%a,' '%b' '%d,' '%Y' '%I:%M:%S' '%p)
UTC Time: $(date -ud @$(date +%s))
Seconds since Epoch[1/1/1970]: $(date +%s.%N)\n\n"
}

function datetimemain
{
   clear
   while ( true )
   do
      echo -e "    \e[0;45;1;36mDate/Time Home Menu \e[0m"
      echo
      echo -e "\e[1;36m[0]\e[0m \e[1;31mExit Program.\e[0m"
      echo -e "\e[1;36m[1]\e[0m \e[1;35mMonitor Current TimeZone Date and Time.\e[0m"
      echo -e "\e[1;36m[2]\e[0m \e[1;35mMonitor Current UTC Date and Time.\e[0m"
      echo -e "\e[1;36m[3]\e[0m \e[1;35mMonitor Time Passed Since Epoch [1/1/1970].\e[0m"
      echo -e "\e[1;36m[4]\e[0m \e[1;35mMonitor All Above Options in real time.\e[0m"
      echo
      echo -e "\e[1;4;34mChoose one of the following numerical options:\e[0m"
      read -s -N 1 userInput

      if [ -z $userInput ]
      then
         datetimemain
      elif [ $userInput == '0' ]
      then
         exit
      elif [ $userInput == '1' ]
      then
         monitor currentTime
      elif [ $userInput == '2' ]
      then
         monitor utcTime
      elif [ $userInput == '3' ]
      then
         monitor epochTime
      elif [ $userInput == '4' ]
      then
         monitor displayAllTimeOptions
      else
         datetimemain
      fi
   done
}


datetimemain