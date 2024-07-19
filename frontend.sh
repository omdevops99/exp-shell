source common.sh

echo -e "${color} installing the nginx \e[0m" 

dnf install nginx -y &>>$log_file
status_check

echo -e "${color}copy expense config file \e[0m"

cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
status_check

echo -e "${color} removing the file \e[0m"

rm -rf /usr/share/nginx/html/* &>>$log_file
status_check  

echo -e "${color} removing the file \e[0m"

curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/expense.log
status_check

echo -e "${color} changing the directory \e[0m"

cd /usr/share/nginx/html &>>$log_file
status_check

echo -e "${color} unzip the file \e[0m"
unzip /tmp/frontend.zip &>>$log_file
status_check

echo -e "${color} Enable & restart the nginx \e[0m"
status_check 

systemctl enable nginx  &>>$log_file
systemctl restart nginx &>>$log_file

status_check












