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
read -r -p "1. Web Server \n 2. Database Server \n 3. Check Status \n Option (1|2|3) : " input 

function web
{

  ## Install Web Server
  echo -e "$Cyan \n Installing Web Server $Color_Off"
  sudo apt-get install -y apache2 php php-mysql
  
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

function stat
{

  ##Checking Services Status
  echo -e "$Cyan \n Checking Services $Color_Off"

  stat = dead

  for serv in apache2 mysql
   do
   sudo service $serv status | grep -i 'running\|dead' | awk '{print $3}' | sed 's/[()]//g' | while read output;
    do
    echo $output
      if [ "$output" == "$stat" ]; then
        echo -e "$Cyan \n Starting Service $Color_Off" 
        sudo service $serv start
        echo -e "$Green \n $serv service is UP now !"
      else
        echo -e "$Green \n $serv service is running"
      fi
    done
  done

}

## Running Command
if [ $input -eq 1 ]; then web
elif [ $input -eq 2 ]; then db
elif [ $input -eq 3 ]; then stat
else echo "No option matched"
fi
