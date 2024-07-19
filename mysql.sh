source common.sh

if [ -z "$1" ]; then
  echo password input missing
  exit
fi

MYSQL_ROOT_PASSWORD=$1

echo -e "${color} disable mysql \e[0m"

dnf module disable mysql -y &>>$log_file
status_check

echo -e "${color} copy the repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
status_check

echo -e "${color} install mysql \e[0m"

dnf install mysql-community-server -y &>>$log_file
status_check


echo -e "${color} start the mysqld services \e[0m"

systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file  
status_check

echo -e "${color} load the schema \e[0m"

mysql_secure_installation --set-root-pass ${MYSQL_ROOT_PASSWORD} &>>$log_file
status_check
