#!/bin/bash

source ./BashLib/*.sh

out2file=""

echo -e "$(tput setab 0)"

function currentTime
{
   
   echo -e "$(tput setaf 5 ; tput bold)"

   if [ $out2file == "-f" ]
   then
      time printf "$(date +Date:' '%A,' '%B-%d-%Y%n$(date +%Z)' 'Time:' '%I:%M:%S' '%p)\n\n" | tee datetime.log
   else
      time printf "$(date +Date:' '%A,' '%B-%d-%Y%n$(date +%Z)' 'Time:' '%I:%M:%S' '%p)\n\n"
   fi
}

function utcTime
{
   
   echo -e "$(tput setaf 5 ; tput bold)"
   
   if [ $out2file == "-f" ]
   then
      time printf "UTC Time: $(date -ud @$(date +%s))\n\n" | tee datetime.log
   else
      time printf "UTC Time: $(date -ud @$(date +%s))\n\n"
   fi
}

function epochTime
{

   echo -e "$(tput setaf 5 ; tput bold)"

   if [ $out2file == "-f" ]
   then
      time printf "Seconds since Epoch[1/1/1970]: $(date +%s.%N)\n\n" | tee datetime.log
   else
      time printf "Seconds since Epoch[1/1/1970]: $(date +%s.%N)\n\n"
   fi
}

function displayAllTimeOptions
{

   echo -e "$(tput setaf 5 ; tput bold)"

   if [ $out2file == "-f" ]
   then
      time printf "$(date +%Z' 'Time:' '%a,' '%b' '%d,' '%Y' '%I:%M:%S' '%p)
UTC Time: $(date -ud @$(date +%s))
Seconds since Epoch[1/1/1970]: $(date +%s.%N)\n\n" | tee datetime.log
   else

      time printf "$(date +%Z' 'Time:' '%a,' '%b' '%d,' '%Y' '%I:%M:%S' '%p)
UTC Time: $(date -ud @$(date +%s))
Seconds since Epoch[1/1/1970]: $(date +%s.%N)\n\n"

   fi
}

function log2fileprompt
{
   clear
   arg1=$1

   if [ -z $arg1 ]
   then
      echo -e "\e[1;33m\nThe date/time option selected can be written to log file.\e[0m"
      echo -e "\e[1;33mThe file will be overwritten in real time with the most recent output.\e[0m"
      echo -e "\e[1;33mOutput will be generated in datetime.log in the current dir. \e[0m"
      echo -e "\e[1;34m\n\nWould you like to output date/time to log file?\e[0m \e[1;36m[y/n]\e[0m"
      read -s -N 1 out2file

      if [ -z $out2file ]
      then
         log2fileprompt
      elif [ $out2file == "y" ]
      then
        out2file="-f"
      elif [ $out2file != "n" ]
      then
         log2fileprompt
      fi
   fi

}

function datetimemain
{
   out2file=$1
   clear
   while ( true )
   do
      echo -e "\e[1;36m@author\e[0m \e[1;37m[Neal Patel]\e[0m \e[4;34m[https://github.com/nealspatel96]\e[0m\n\n\n"
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
         datetimemain $1
      elif [ $userInput == '0' ]
      then
         exit
      elif [ $userInput == '1' ]
      then
         log2fileprompt $1
         monitor currentTime $out2file
      elif [ $userInput == '2' ]
      then
         log2fileprompt $1
         monitor utcTime $out2file
      elif [ $userInput == '3' ]
      then
         log2fileprompt $1
         monitor epochTime $out2file
      elif [ $userInput == '4' ]
      then
         log2fileprompt $1
         monitor displayAllTimeOptions $out2file
      else
         datetimemain $1
      fi

      if [ $out2file == "-f" ]
      then
         cp /dev/null ./datetime.log
      fi

   done
}


datetimemain