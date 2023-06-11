#! /bin/bash

defaulteditor="$(git config --global core.editor)"

function NameSetup
{
   echo -e "\e[1;33mtype in your first name: \e[0m"
   read firstname
   echo -e "\e[1;33mtype in your last name: \e[0m"
   read lastname
   fullname="$firstname $lastname"

   git config --global user.name "$fullname"
}

function EmailSetup
{
   echo -e "\e[1;33mtype in your email to configure with Git: \e[0m"
   read usremail
   sleep 1
   echo -e "\e[1;33mplease confirm the email: $usremail\e[0m"
   echo -e "\e[1;33mis this correct? \e[1;36m[y/n]\e[0m: "
   read -s -N 1 usrconfirm
   if [ $usrconfirm == 'y' ]
   then
      git config --global user.email $usremail
   else
      clear
      EmailSetup  
   fi
}

function EditorSetup
{
   echo -e "\e[1;36m[1] \e[1;35mvim [default option]\e[1;0m"
   echo -e "\e[1;36m[2] \e[1;35mnano\e[0m"
   echo -e "\e[1;36m[3] \e[1;35mnotepad\e[0m"
   echo -e "\e[1;33mChoose one of the following numerical options for Git setup:\e[0m"
   read -N 1 editorOption
   if [ -z $editorOption ]
   then
      defaulteditor="vim"
   elif [ $editorOption == '1' ]
   then
      defaulteditor="vim"
   elif [ $editorOption == '2' ]
   then
      defaulteditor="nano"
   elif [ $editorOption == '3' ]
   then
      defaulteditor="notepad"
   else
      defaulteditor="vim"
   fi

   git config --global core.editor $defaulteditor
}

function GitSetup
{
   echo -e "\e[1;32mSetting up Git Config...\e[0m"

   if [ ! -f ~/.gitconfig ]
   then
      printf "File Not Found. Creating $HOME/.gitconfig ...\n"
      > ~/.gitconfig
      chmod 0644 ~/.gitconfig
      chown $USERNAME ~/.gitconfig
   fi

   # the '$?' is an exit status 0 -> true (pattern found), 1 -> false (pattern not found)
   checkName=$(grep -q "name" ~/.gitconfig && echo $?)
   if [ -z $checkName ]
   then
      NameSetup
   elif [ $checkName == '1' ]
   then
      NameSetup
   fi
   echo -e "\e[1;31m$(cat ~/.gitconfig | grep "name")\e[0m"

   
   checkemail=$(grep -q "email" ~/.gitconfig && echo $?)
   if [ -z $checkemail ]
   then
      EmailSetup
   elif [ $checkemail == '1' ]
   then
      EmailSetup
   fi
   echo -e "\e[1;31m$(cat ~/.gitconfig | grep "email")\e[0m"


   checkeditor=$(grep -q "editor" ~/.gitconfig && echo $?)
   if [ -z $checkeditor ]
   then
      EditorSetup
   elif [ $checkeditor == '1' ]
   then 
      EditorSetup
   fi
   echo -e "\e[1;31m$(cat ~/.gitconfig | grep "editor")\e[0m"

   checkautocrlf=$(grep -q "autocrlf" ~/.gitconfig && echo $?)
  if [ -z $checkautocrlf ]
  then
     git config --global core.autocrlf false
  fi

  echo -e "\e[1;31m$(cat ~/.gitconfig | grep "autocrlf")\e[0m"

 if [ $OSTYPE == "linux-gnu" ]
 then
    checkcolorui=$(grep -q "[color]" ~/.gitconfig && echo $?)
    if [ -z $checkcolorui ]
    then
       git config --global color.ui true
    fi
    echo -e "\e[1;31m$(cat ~/.gitconfig | grep "ui")\e[0m"
 fi


   echo -e "\e[1;32mGit setup Finished.\e[1;0m"
}

function GitOptions
{
   while (true)
   do
      printf "\e[1;36;45m\nMenu Options\n\n\e[0m"
      echo -e "\e[1;36m[0] \e[1;31mExit Script.\e[0m"
      echo -e "\e[1;36m[1] \e[1;35mLaunch .gitconfig with default editor for Git\e[0m"
      echo -e "\e[1;36m[2] \e[1;35mClear all set configurations in .gitconfig\e[0m"
      echo -e "\e[1;36m[3] \e[1;35mRelaunch Git Configuration setup.\e[0m"
      echo -e "\e[1;33mChoose one of the above options:\e[0m"
      read -s -N 1 userOption
   
      if [ -z $userOption ]
      then
         clear
      elif [ $userOption == '0' ]
      then
         exit
      elif [ $userOption == '1' ]
      then
         eval $defaulteditor ~/.gitconfig
         clear
         sleep 1
      elif [ $userOption == '2' ]
      then
         clear
         echo -e "\e[1;32mErasing the contents of .gitconfig\e[0m"
         cp /dev/null ~/.gitconfig
         echo -e "\e[1;32mContents of .giconfig erased.\e[0m"
         echo -e "\e[1;33mWarning! You need to setup git configuration to be able to use Git properly.\e[0m"
         echo -e "\e[1;33mRerun this script to setup your configutations.\e[0m"
         echo -e "\n\e[1;37mPress any key to continue to menu options...\e[0m"
         read -N 1
      elif [ $userOption == '3' ]
      then
         clear
         GitSetup   
      else
         clear
      fi
   done
}


GitSetup
GitOptions