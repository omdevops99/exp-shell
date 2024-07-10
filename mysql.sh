log_file=/tmp/expense.log
color="\e[33m"

echo -e "${color} disable mysql \e[0m"

dnf module disable mysql -y &>>$log_file
echo $?


echo -e "${color} install mysql \e[0m"

dnf install mysql-community-server -y &>>$log_file
echo $?

echo -e "${color} copy the repo \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
echo $?

echo -e "${color} start the mysqld services \e[0m"

systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file  
echo $?

echo -e "${color} load the schema \e[0m"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
echo $?
