#!/bin/bash

if [ $OSTYPE == "msys" ]
then
   usrname=$USERNAME
elif [ $OSTYPE == "linux-gnu" ]
then
   usrname=$USER
fi

function SetupRsaKeys
{
   sshdir=~/.ssh
   if [ ! -d $sshdir ]
   then
      echo "Creating .ssh directory."
      mkdir ~/.ssh
      chown $usrname ~/.ssh
      chmod 0755 ~/.ssh
   fi

   echo "Would you like to generate new rsa keys? [y/n]"
   read usrInRsa
   if [ -z $usrInRsa ]
   then
      echo ""
   elif [ $usrInRsa == 'y' ]
   then
      curdir=$(pwd)
      cd ~/.ssh
      ssh-keygen -t rsa -N ""      
   fi
}

SetupRsaKeys