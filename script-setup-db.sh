
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
  echo -e "$Cyan \n === Are you want to setup database ? === $Color_Off"
  echo -e "1. Yes, Continue \n2. No, Abort \nOption (1|2) ? "
  read -p "Answer : " input


  echo -e "$Cyan \n === Bind IP MYSQL === $Color_Off"
  sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
  echo -e "$Green Success bind $ip_address $Color_Off"
  echo -e "$Cyan \n === Restart MYSQL Service === $Color_Off" 
  sudo service mysql restart
  echo -e "$Green Done $Color_Off"

  if [ $input -eq 1 ];then

     # Cloning Repository
       mkdir /home/$USER/projects
       cd /home/$USER/projects/
       echo -e "$Cyan \n === Clone Source Code Wordpress === $Color_Off"
       git clone https://github.com/Jasnicahuang/WordPress.git jasnica-wordpress
       echo -e "$Cyan \n === Clone Source Code Social-Media === $Color_Off"
       git clone https://github.com/Jasnicahuang/sosial-media.git social-media

     echo -e "$Cyan \n === Setup Database Social-Media === $Color_Off"
     read -r -p "Do you want to setup Social-Media Database? (Y/N) : " smdb_choice
     if [ $smdb_choice == "Y" -o $smdb_choice == "y" ]; then

        sudo mysql -u root <<CMD_EOF
        CREATE USER 'devopscilsy'@'%' IDENTIFIED BY '1234567890';
        CREATE DATABASE dbsosmed;
        GRANT ALL PRIVILEGES ON *.* TO 'devopscilsy'@'%';
        FLUSH PRIVILEGES;
CMD_EOF
     echo -e "$Cyan \n === Import Dump SQL to DBSOSMED === $Color_Off"
        sudo mysql -u devopscilsy -p dbsosmed < /home/$USER/projects/social-media/dump.sql
     echo -e "$Green Done $Color_Off"
     else
         echo "Skipped"
     fi

     echo -e "$Cyan \n === Setup Database Wordpress === $Color_Off"
     read -r -p "Do you want to setup Wordpress Database? (Y/N) : " wpdb_choice
     if [ $wpdb_choice == "Y" -o $wpdb_choice == "y" ]; then
        read -r -p " [1.1] Enter Wordpress 'Database Name', you want to create : " wpdb_name
                read -r -p " [1.2] Enter Wordpress 'Database Username', you want to create : " wpdb_user
                read -r -p " [1.3] Enter Wordpress 'Database Password', you want to create : " wpdb_password
     else
         echo "Skipped" 
     fi

        if [ -z $wpdb_name ]; then wpdb_name='wordpress'; fi
        if [ -z $wpdb_user ]; then wpdb_user='wp_user'; fi
        if [ -z $wpdb_password ]; then wpdb_password='wp_password'; fi

        sudo mysql -u root -p <<CMD_EOF
        CREATE USER '$wpdb_user'@'%' IDENTIFIED BY '$wpdb_password';
        CREATE DATABASE $wpdb_name;
        GRANT ALL PRIVILEGES ON $wpdb_name.* TO '$wpdb_user'@'%' IDENTIFIED BY '$wpdb_password';
        FLUSH PRIVILEGES;
CMD_EOF

     echo -e "$Green \n === Setup Database Server Completed === $Color_Off"

  else
      echo "Abort Setup Database Server"
      exit 1
  fi

