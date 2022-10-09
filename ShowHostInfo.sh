#! /bin/bash

clear

function exitprompt
{
   echo "would you like to choose another option? [y/n]"
   read -s -N 1 userAns
   if [ $userAns == 'y' ]
   then
      clear
   else
      echo "Press any key to exit the script..."
      read -s -N 1
      exit  
   fi
}

function netInfo
{

   clear
   echo "Network Info Menu"
   echo
   echo "[1] Network Interfaces and IP Addresses"
   echo "[2] Routing Table IPv4"
   echo "[3] Routing Table IPv6"
   echo "[4] Port Information"
   echo "[5] ARP info"
   echo "[6] Firewall status"
   echo "[7] DNS Information"
   echo "choose one of the following options:"
   read -s -N 1 userInput
   if [ $OSTYPE == "msys" ]
   then
      if [ -z $userInput ]
      then
         echo "No selection made."
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
         printf "\nDNS Cache Entry: "
         ipconfig //displaydns
      else
         echo "Invalid Input"
      fi
   elif [ $OSTYPE == "linux-gnu" ]
   then
      if [ -z $userInput ]
      then
         echo "No selection made."
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
         echo "Invalid Input"
      fi
   else
      echo "Script does not support your OS."
   fi
}

function showhostinfo
{
   if [ $OSTYPE = "msys" ]
   then
      while [ true ]
      do
         echo "Hostname: $COMPUTERNAME"
         echo "Username: $USERNAME"
         echo "Warning: Some features may require admin privileges in some hosts."
         echo
         echo "   Windows HostInfo Home Menu"
         echo 
         echo "[0] Exit Program"
         echo "[1] Show detailed system information"
         echo "[2] Show network information"
         echo "[3] Show environment variables"
         echo "[4] Show disk partition information"
         echo "[5] Show cpu  information"
         echo "[6] Show memory information"
         echo "[7] Show current user tasks"
         echo "[8] Start resource monitor"
         echo "Choose one of the following options [type the number]:"
         read -s -N 1 userOption
         clear
         if [ -z $userOption ]
         then
            echo "No selection made."
         elif [ $userOption == '0' ]
         then
            exit
         elif [ $userOption == '1' ]
         then
            systeminfo
            echo "Launch msinfo32 GUI? [y/n]"
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
            echo "Would you like to start the Environment Variables GUI? [y/n]:"
            read -s -N 1 envans
            if [ $envans == 'y' ]
            then
               echo "Launching Environment Variables GUI..."
               cmd //c rundll32 sysdm.cpl,EditEnvironmentVariables &
               envans='n'
            fi
         elif [ $userOption == '4' ]
         then
            df -h
            echo "Would you like to Disk Management GUI? [y/n]:"
            read -s -N 1 dskans
            if [ $dskans == 'y' ]
            then
               cmd //c diskmgmt
               dskans='n'
            fi
         elif [ $userOption == '5' ]
         then
            echo "wmic CPU information:"
            echo
            cmd //c wmic cpu list //format:list
         elif [ $userOption == '6' ]
         then
           cmd //c systeminfo | findstr Memory
         elif [ $userOption == '7' ]
         then
            echo "would you like to search for a specific task name thats running? [y/n]:"
            read -s -N 1 tskschqst
            if [ $tskschqst == 'y' ]
            then
               echo "enter the name of the task(s) [no spaces]:"
               read tsksrch
               tasklist //S $COMPUTERNAME //U $USERNAME | findstr $tsksrch
            else
               tasklist //S $COMPUTERNAME //U $USERNAME
            fi
            echo "would you like to start task manager? [y/n]:"
            read -s -N 1 tskans
            if [ $tskans == 'y' ]
            then
               echo "Launching Task Manager..."
               cmd //c taskmgr &
               tskans='n'
            fi
         elif [ $userOption == '8' ]
         then
            echo "Launching Resource Monitor..."
            cmd //c resmon &
         else
            echo "Invalid User Input."
         fi
         exitprompt
      done
   elif [ $OSTYPE = "linux-gnu" ]
   then
      while (true)
      do
         echo "Hostname: $HOSTNAME"
         echo "username: $USER"
         echo "Warning: Some features may require admin privileges in some hosts."
         echo
         echo "   Linux HostInfo Home Menu"
         echo 
         echo "0. Exit Program"
         echo "1. Show cpu  information"
         echo "2. Show memory block information"
         echo "3. Show network information"
         echo "4. Show environment variables"
         echo "5. Show disk partition information"
         echo "6. Show current user tasks"
         echo "7. Show PCI information"
         echo "Choose one of the following options [type the number]:"
         read -s -N 1 userOption

         if [ -z $userOption ]
         then
            echo "No selection made."
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
            echo "Invalid User Input."
         fi
         exitprompt
      done
   else
      echo "the following script is not supported for your computer based on your Operating System"
   fi


}

showhostinfo