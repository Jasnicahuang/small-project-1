
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
  sudo sed -i 's/127.0.0.1/192.168.25.3/g' /etc/mysql/mysql.conf.d/mysqld.cnf
  echo -e "$Green Success bind 192.168.25.3 $Color_Off"

  if [ $input -eq 1 ];then

     # Cloning Repository
       mkdir /home/$USER/projects
       cd /home/$USER/projects/
       echo -e "$Cyan \n === Clone Source Code Wordpress === $Color_Off"
       git clone https://github.com/Jasnicahuang/WordPress.git jasnica-wordpress
       echo -e "$Cyan \n === Clone Source Code Social-Media === $Color_Off"
       git clone https://github.com/Jasnicahuang/sosial-media.git social-media

     read -r -p "Do you want to setup Social-Media Database? (Y/N) : " smdb_choice
     if [ $smdb_choice == "Y" -o $smdb_choice == "y" ]; then

        sudo mysql -u root <<CMD_EOF
        CREATE USER 'devopscilsy'@'localhost' IDENTIFIED BY '1234567890';
        GRANT ALL PRIVILEGES ON *.* TO 'devopscilsy'@'localhost';
        CREATE DATABASE dbsosmed;
CMD_EOF
        sudo mysql -u devopscilsy -p dbsosmed < /home/$USER/projects/social-media/dump.sql
     else
         echo "Skipped"
     fi

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

        sudo mysql -u root <<CMD_EOF
        CREATE USER '$wpdb_user'@'localhost' IDENTIFIED BY '$wpdb_password';
        CREATE DATABASE $wpdb_name;
        GRANT ALL PRIVILEGES ON $wpdb_name.* TO '$wpdb_user'@'localhost' IDENTIFIED BY '$wpdb_password';
        FLUSH PRIVILEGES;
CMD_EOF

     else
         echo "Skipped"
     fi

  else
      echo "Abort Setup Database Server"
      exit 1
  fi

