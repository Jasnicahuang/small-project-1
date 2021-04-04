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
    sudo service apache2 restart

    declare -a repo=("landing-page" "jasnica-wordpress" "social-media")
    repolength=${#repo[@]}
    for (( i=1; i<${repolength}+1; i++));
    #for dir in landing-page jasnica-wordpress social-media
      do
        echo -e "$Yellow \n === Create Directory ${repo[$i-1]} in /var/www === $Color_Off"
        mv /home/vagrant/projects/${repo[$i-1]} /var/www/"${repo[$i-1]}.com"
        echo -e "$Green Folder ${repo[$i-1]}.com created in /var/www/ $Color_Off"
        sudo chown -R $USER:$USER /var/www/"${repo[$i-1]}.com"
        sudo chmod -R 755 /var/www/"${repo[$i-1]}.com"
        echo -e "$Yellow \n === Create File Config ${repo[$i-1]} in /etc/apache2/sites-available === $Color_Off"
        sudo echo -en "<Directory /var/www/${repo[$i-1]}.com>\n\tAllowOverride All\n</Directory>" >/etc/apache2/sites-available/"${repo[$i-1]}.com".conf
        sudo echo -en "\n<VirtualHost *:808$i>\n\tServerAdmin admin@${repo[$i-1]}.com\n\tServerName ${repo[$i-1]}.com\n\tServerAlias www.${repo[$i-1]}.com\n\tDocumentRoot /var/www/${repo[$i-1]}.com" >>/etc/apache2/sites-available/"${repo[$i-1]}.com".conf
        sudo echo -e "\n\tErrorLog \${APACHE_LOG_DIR}/error.log\n\tCustomLog \${APACHE_LOG_DIR}/access.log combined\n</VirtualHost>" >>/etc/apache2/sites-available/"${repo[$i-1]}.com".conf
        sudo -- sh -c "echo Listen 808$i >> /etc/apache2/ports.conf"
        echo -e "$Green \n === Enabled Link ${repo[$i-1]} === $Color_Off"
        sudo a2ensite "${repo[$i-1]}.com".conf
        sudo service apache2 restart
        echo -e "$Yellow \n === Adding Server Name ${repo[$i-1]} into /etc/hosts === $Color_Off"
        sudo -- sh -c "echo $(hostname -I | awk '{print $2}') ${repo[$i-1]}.com >> /etc/hosts"

        echo -e "$Yellow \n === Configure Files on ${repo[$i-1]}.com === $Color_Off"
        if [ ${repo[$i-1]} == "social-media" ]; then
           sudo sed -i 's/localhost/192.168.25.3/g' /var/www/"${repo[$i-1]}.com"/config.php
           echo -e "$Green Done $Color_Off"
        elif [ ${repo[$i-1]} == "jasnica-wordpress" ]; then
             read -r -p "Do you want to setup Wordpress Config? (Y/N) : " wpdb_choice
	     if [ $wpdb_choice = 'Y' -o $wpdb_choice = 'y' ]; then
		read -r -p " [1.1] Enter Wordpress 'Database Name', you want to create : " wpdb_name
		read -r -p " [1.2] Enter Wordpress 'Database Username', you want to create : " wpdb_user
		read -r -p " [1.3] Enter Wordpress 'Database Password', you want to create : " wpdb_password
	     fi

             if [ -z $wpdb_name ]; then wpdb_name='wordpress'; fi
             if [ -z $wpdb_user ]; then wpdb_user='wp_user'; fi
             if [ -z $wpdb_password ]; then wpdb_password='wp_password'; fi

             sudo cp /var/www/"${repo[$i-1]}.com"/wp-config-sample.php /var/www/"${repo[$i-1]}.com"/wp-config.php
             sudo sed -i 's/database_name_here/'$wpdb_name'/g' /var/www/"${repo[$i-1]}.com"/wp-config.php
	     sudo sed -i 's/username_here/'$wpdb_user'/g' /var/www/"${repo[$i-1]}.com"/wp-config.php
	     sudo sed -i 's/password_here/'$wpdb_password'/g' /var/www/"${repo[$i-1]}.com"/wp-config.php
             sudo sed -i 's/localhost/192.168.25.3/g' /var/www/"${repo[$i-1]}.com"/wp-config.php
             echo -e "$Green Done $Color_Off"
        else
             echo -e "$Green Done $Color_Off"
        fi
      done
    echo -e "$Cyan \n === Restart Service Apache === $Color_Off"
    sudo service apache2 restart
    echo -e "$Cyan Setup Web Server Completed $Color_Off"
  else
      echo "Abort Setup Web Server"
      exit 1
  fi
