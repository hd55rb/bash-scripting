#!/bin/bash

# Function to update the system
update_system() {
  echo "Updating system ..."
  sudo apt upgrade
  sudo apt install
}

# Function to install Apache
install_apache() {
  echo "Installing Apache..."
  sudo apt-get install apache2 -y & wait
  sudo ufw allow in "Apache"
  sudo systemctl start apache2
  sudo systemctl enable apache2
}

# Function to install Nginx
install_nginx() {
  echo "Installing Nginx..."
  sudo apt-get install nginx -y & wait
  sudo ufw allow 'Nginx Full'
  sudo systemctl start nginx
  sudo systemctl enable nginx
}

# Function to install MySQL
install_mysql() {
  echo "Installing MySQL..."
  sudo apt-get install mysql-server -y & wait
  sudo systemctl reload apache2
  sudo systemctl status mysql
}

# Function to install PHP
install_php() {
  echo "Installing PHP..."
  sudo apt-get install php libapache2-mod-php php-mysql -y & wait
  sudo systemctl restart apache2
}

# Function to install the entire LAMP stack
install_lamp() {
  update_system
  install_apache
  install_mysql
  install_php
}

# Function to install the entire LEMP stack
install_lemp() {
  update_system
  install_nginx
  install_mysql
  install_php
}

# Function to display menu and get user choice
show_menu() {
  echo "Choose an option to install:"
  echo "1) Install Full LAMP Stack"
  echo "2) Install Full LEMP Stack"
  echo "3) Exit"
  read -rp "Enter your choice [1-3]: " choice
  case $choice in
    1)
      install_lamp
      ;;
    2)
      install_lemp
      ;;
    3)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please select a valid option."
      show_menu
      ;;
  esac
}

# Main function to execute the menu
main() {
  show_menu
}

# Execute the main function
main

echo "Installation completed"
