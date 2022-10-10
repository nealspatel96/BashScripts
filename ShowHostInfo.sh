#! /bin/bash

clear

function back2menu
{   
   echo -e "\e[1;35mPress any key to go back to menu...\e[0m"
   read -s -N 1
   clear
}

function netInfo
{

   clear
   printf "\e[1;32;44mNetwork Info Menu\e[0m\n\n"
   printf "\e[1;36m[1] \e[1;34mNetwork Interfaces and IP Addresses\e[0m\n"
   printf "\e[1;36m[2] \e[1;34mRouting Table IPv4\e[0m\n"
   printf "\e[1;36m[3] \e[1;34mRouting Table IPv6\e[0m\n"
   printf "\e[1;36m[4] \e[1;34mPort Information\e[0m\n"
   printf "\e[1;36m[5] \e[1;34mARP info\e[0m\n"
   printf "\e[1;36m[6] \e[1;34mFirewall status\e[0m\n"
   printf "\e[1;36m[7] \e[1;34mDNS Information\e[0m\n"
   printf "\e[4;33mchoose one of the following options:\e[0m\n"
   read -s -N 1 userInput

   if [ $OSTYPE == "msys" ]
   then
      if [ -z $userInput ]
      then
         netInfo
      elif [ $userInput == '1' ]
      then
         ipconfig //all
      elif [ $userInput == '2' ]
      then
         route print -4
      elif [ $userInput == '3' ]
      then
         route print -6
      elif [ $userInput == '4' ]
      then
         netstat -n
      elif [ $userInput == '5' ]
      then
         arp -a
      elif [ $userInput == '6' ]
      then
         cmd //c netsh advfirewall show currentprofile
      elif [ $userInput == '7' ]
      then
         printf "\e[1;32m\nDNS Cache Entry: \e[0m"
         ipconfig //displaydns
      else
         netInfo
      fi
   elif [ $OSTYPE == "linux-gnu" ]
   then
      if [ -z $userInput ]
      then
         netInfo
      elif [ $userInput == '1' ]
      then
         ip a
      elif [ $userInput == '2' ]
      then
         ip -4 route show
      elif [ $userInput == '3' ]
      then
         ip -6 route show
      elif [ $userInput == '4' ]
      then
         ss -n
      elif [ $userInput == '5' ]
      then
         arp -a
      elif [ $userInput == '6' ]
      then
         systemctl status firewalld
      elif [ $userInput == '7' ]
      then
         cat /etc/resolv.conf | less
      else
         netInfo
      fi
   else
      echo -e "\e[1;31mScript does not support your OS.\e[0m"
   fi
}

function showhostinfo
{
   if [ $OSTYPE = "msys" ]
   then
      while [ true ]
      do
         printf "\e[1;35mHostname: $COMPUTERNAME\nUsername: $USERNAME\e[0m\n\n"
         printf "\e[1;31mWarning: Some features may require admin privileges in some hosts.\e[0m\n\n"
         printf "   \e[1;32;44mWindows HostInfo Home Menu\e[0m\n\n"
         printf "\e[1;36m[0] \e[1;31mExit Program\e[0m\n"
         printf "\e[1;36m[1] \e[1;34mShow detailed system information\e[0m\n"
         printf "\e[1;36m[2] \e[1;34mShow network information\e[0m\n"
         printf "\e[1;36m[3] \e[1;34mShow environment variables\e[0m\n"
         printf "\e[1;36m[4] \e[1;34mShow disk partition information\e[0m\n"
         printf "\e[1;36m[5] \e[1;34mShow cpu  information\e[0m\n"
         printf "\e[1;36m[6] \e[1;34mShow memory information\e[0m\n"
         printf "\e[1;36m[7] \e[1;34mShow current user tasks\e[0m\n"
         printf "\e[1;36m[8] \e[1;34mStart resource monitor\e[0m\n"
         printf "\e[4;33mChoose one of the following numerical options:\e[0m\n"
         read -s -N 1 userOption
         clear
         if [ -z $userOption ]
         then
            continue
         elif [ $userOption == '0' ]
         then
            exit
         elif [ $userOption == '1' ]
         then
            systeminfo
            echo -e "\e[1;33mLaunch msinfo32 GUI? \e[1;36m[y/n]\e[0m"
            read -s -N 1 ms32ans
            if [ $ms32ans == 'y' ]
            then
               msinfo32 &
               ms32ans='n'
            fi
         elif [ $userOption == '2' ]
         then
            netInfo
         elif [ $userOption == '3' ]
         then
            env -v
            echo -e "\e[1;33mWould you like to start the Environment Variables GUI? \e[1;36m[y/n]\e[0m"
            read -s -N 1 envans
            if [ $envans == 'y' ]
            then
               echo -e "\e[1;32mLaunching Environment Variables GUI...\e[0m"
               cmd //c rundll32 sysdm.cpl,EditEnvironmentVariables &
               envans='n'
            fi
         elif [ $userOption == '4' ]
         then
            df -h
            echo -e "\e[1;33mWould you like to Disk Management GUI? \e[1;36m[y/n]\e[0m"
            read -s -N 1 dskans
            if [ $dskans == 'y' ]
            then
               echo -e "\e[1;32mLaunching Disk Management GUI\e[0m"
               cmd //c diskmgmt &
               dskans='n'
            fi
         elif [ $userOption == '5' ]
         then
            echo -e "\e[1;32mwmic CPU information:\e[0m"
            echo
            cmd //c wmic cpu list //format:list
         elif [ $userOption == '6' ]
         then
           cmd //c systeminfo | findstr Memory
         elif [ $userOption == '7' ]
         then
            echo -e "\e[1;33mWould you like to search for a specific task name thats running? \e[1;36m[y/n]\e[0m"
            read -s -N 1 tskschqst
            if [ $tskschqst == 'y' ]
            then
               echo -e "\e[1;33mEnter the name of the task(s) \e[1;36m[no spaces]\e[0m"
               read tsksrch
               tasklist //S $COMPUTERNAME //U $USERNAME 2> /dev/null | findstr $tsksrch 2> /dev/null 
            else
               tasklist //S $COMPUTERNAME //U $USERNAME 2>/dev/null
            fi
            echo -e "\e[1;33mWould you like to start task manager? \e[1;36m[y/n]\e[0m"
            read -s -N 1 tskans
            if [ $tskans == 'y' ]
            then
               echo -e "\e[1;32mLaunching Task Manager...\e[0m"
               cmd //c taskmgr &
               tskans='n'
            fi
         elif [ $userOption == '8' ]
         then
            echo -e "\e[1;32mLaunching Resource Monitor...\e[0m"
            cmd //c resmon &
         else
            continue
         fi
         back2menu
      done
   elif [ $OSTYPE = "linux-gnu" ]
   then
      while (true)
      do
         printf "\e[1;34mHostname: $HOSTNAME\nusername: $USER\e[0m\n\n"
         printf "\e[1;33mWarning: Some features may require admin privileges in some hosts.\e[0m\n\n"
         printf "   \e[1;32;35mLinux HostInfo Home Menu\e[0m\n\n"
         printf "\e[1;36m[0] \e[1;31mExit Script.\e[0m\n"
         printf "\e[1;36m[1] \e[1;34mShow cpu  information\e[0m\n"
         printf "\e[1;36m[2] \e[1;34mShow memory block information\e[0m\n"
         printf "\e[1;36m[3] \e[1;34mShow network information\e[0m\n"
         printf "\e[1;36m[4] \e[1;34mShow environment variables\e[0m\n"
         printf "\e[1;36m[5] \e[1;34mShow disk partition information\e[0m\n"
         printf "\e[1;36m[6] \e[1;34mShow current user tasks\e[0m\n"
         printf "\e[1;36m[7] \e[1;34mShow PCI information\e[0m\n"
         printf "\e[4;33mChoose one of the following numerical options:\e[0m\n"
         read -s -N 1 userOption

         if [ -z $userOption ]
         then
            continue
         elif [ $userOption == '1' ]
         then
            lscpu
         elif [ $userOption == '2' ]
         then
            lsmem
         elif [ $userOption == '3' ]
         then
            netInfo
         elif [ $userOption == '4' ]
         then
            env
         elif [ $userOption == '5' ]
         then
            df -h
         elif [ $userOption == '6' ]
         then
            top -u $USER
         elif [ $userOption == '7' ]
         then
            lspci
         else
            continue
         fi
         back2menu
      done
   else
      echo -e "\e[1;31mThe following script is not supported for your computer based on your Operating System\e[0m\n"
   fi


}

showhostinfo