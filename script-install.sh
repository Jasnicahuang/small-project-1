#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan


# Update packages and Upgrade system
echo -e "$Cyan \n === Updating Packages === $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

# Choose Install
echo -e "$Cyan \n === Choose Install or Check Status === $Color_Off"
echo -e "1. Web Server \n2. Database Server \n3. Check Status \nOption (1|2|3) ? "
read -p "Answer : " input

function web
{

  ## Install Web Server
  echo -e "$Cyan \n Installing Web Server $Color_Off"
  sudo apt-get install -y apache2 php php-mysql
  sudo service apache2 start
  ## Permissions
  echo -e "$Cyan \n Permissions for /var/www $Color_Off"
  `sudo chown -R $USER:$USER /var/www`
  echo -e "$Green \n Permissions have been set $Color_Off"

}

function db
{

  ## Instal DB Server
  echo -e "$Cyan \n Installing Database Server $Color_Off"
  sudo apt-get install -y mysql-server
  sudo mysql_secure_installation

}

function check
{
  
  ##Checking Services Status
  read -p "Check Service : " serv

  local output="`sudo service $serv status | grep -i 'running\|dead' | awk '{print $3}' | sed 's/[()]//g'`"
  
  if [ "${output}" == "running" ]; then
        echo -e "$Green $serv service is RUNNING $Color_Off"
  elif [ "${output}" == "dead" ]; then
        echo -e "$Red $serv service is DOWN now ! $Color_Off"
        echo -e "$Cyan \n Starting Service $Color_Off" 
        sudo service $serv start
        echo -e "$Green \n $serv service is UP now !"
  else
        echo -e "$Red $serv is not installed ! $Color_Off"
  fi

}

## Running Command
if [ $input -eq 1 ]; then web
elif [ $input -eq 2 ]; then db
elif [ $input -eq 3 ]; then check
else echo -e "$Red No option matched $Color_Off"
fi
