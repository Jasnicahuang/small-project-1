#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

# Choose Setup
  echo -e "$Cyan \n === Are you want to setup web ? === $Color_Off"
  echo -e "1. Yes, Continue \n2. No, Abort \nOption (1|2) ? "
  read -p "Answer : " input

  if [ $input -eq 1 ]; then

  # Getting Source Code Web
    echo -e "$Yellow \n === Create directory to hold repo git === $Color_Off"
    mkdir /home/$USER/projects
    echo -e "$Green Directory named projects was created $Color_Off"
  # Cloning Repository
    cd /home/$USER/projects/
    echo -e "$Cyan \n === Clone Source Code Landing-Page === $Color_Off"
    git clone https://github.com/Jasnicahuang/landing-page.git
    echo -e "$Cyan \n === Clone Source Code Wordpress === $Color_Off"
    git clone https://github.com/Jasnicahuang/WordPress.git jasnica-wordpress
    echo -e "$Cyan \n === Clone Source Code Social-Media === $Color_Off"
    git clone https://github.com/Jasnicahuang/sosial-media.git social-media

  # Preparing Setup Web
    echo -e "$Red \n === Remove Default Directory Web Server === $Color_Off"
    rm -rf /var/www/html
    echo -e "$Red Remove Directory HTML in /var/www/ $Color_Off"
    echo -e "$Yellow \n === Give Permission User === $Color_Off"
    sudo chown -R $USER:$USER /etc/apache2/sites-available
    sudo chown -R $USER:$USER /var/www/
    echo -e "$Red \n === Disable Apache Default Config === $Color_Off"
    sudo a2dissite 000-default.conf

    for dir in landing-page jasnica-wordpress social-media
      do
        echo -e "$Yellow \n === Create Directory ${dir} in /var/www === $Color_Off"
        mv /home/vagrant/projects/${dir} /var/www/"${dir}.com"
        echo -e "$Green Folder ${dir}.com created in /var/www/ $Color_Off"
        sudo chown -R $USER:$USER /var/www/"${dir}.com"
        sudo chmod -R 755 /var/www/"${dir}.com"
        echo -e "$Yellow \n === Create File Config ${dir} in /etc/apache2/sites-available === $Color_Off"
        sudo echo -en "<Directory /var/www/html/${dir}>\n\tAllowOverride All\n</Directory>" >/etc/apache2/sites-available/"${dir}.com".conf
        sudo echo -en "\n<VirtualHost *:80>\n\tServerAdmin admin@${dir}\n\tServerName ${dir}.com\n\tDocumentRoot /var/www/html/${dir}\n\tErrorLog ${APACHE_LOG_DIR}/error.log\n\tCustomLog ${APACHE_LOG_DIR}/access.log combined\n</VirtualHost>" >>/etc/apache2/sites-available/"${dir}.com".conf
        echo -e "$Green \n === Enabled Link ${dir} === $Color_Off"
        sudo a2ensite "${dir}.com".conf
        echo -e "$Yellow \n === Adding Server Name ${dir} into /etc/hosts === $Color_Off"
        sudo --sh -c "echo -en "$(hostname -I | awk '{print $2}')\t${dir}.com" >>/etc/hosts"
      done
    echo -e "$Cyan \n === Restart Service Apache === $Color_Off"
    sudo service apache2 restart
    echo -e "$Cyan Setup Web Server Completed $Color_Off"
  else
      echo "Abort Setup Web Server"
      exit 1
  fi
