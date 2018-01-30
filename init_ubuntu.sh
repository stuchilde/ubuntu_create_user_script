#!/bin/bash
ROOT_UID=0
SUCCESS=0
E_NOTROOT=60
E_USEREXISTS=70

# Run as root
if [ "${UID}" -ne "${ROOT_UID}" ]
then 
  echo "Must be root to run his script"
  exit ${E_NOTROOT}
fi
#Checkout input parameter
if [ ${#} -eq 2 ]
then 
  username=${1}
  password=${2}
  # checkout if user exist
  grep -q "${username}" /etc/passwd
  if [ ${?} -eq ${SUCCESS} ]
  then
  echo "User ${username} does already exist."
  echo "Please chose another username"
  exit ${E_USEREXISTS}
  fi
  sudo apt-get install whois -y
  sudo apt-get install mkpasswd -y
  useradd -p `mkpasswd "${password}"` -d /home/"${username}" -m -G sudo "${username}"
  echo "the account is setup"
else
  echo " this program needs two parameters, you have given ${#}"
fi
exit 0
