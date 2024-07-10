echo -e "\e[32m installing the nginx \e[0m" 

dnf install nginx -y &>>/tmp/expense.log

echo $?

echo -e "\e[32m copy expense config file \e[0m"

cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log
echo $?

echo -e "\e[32m removing the file \e[0m"

rm -rf /usr/share/nginx/html/*  &>>/tmp/expense.log
echo $?

echo -e "\e[32m removing the file \e[0m"

curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/expense.log
echo $?

echo -e "\e[32m changing the directory \e[0m"

cd /usr/share/nginx/html  &>>/tmp/expense.log
echo $?

echo -e "\e[32m unzip the file \e[0m"
unzip /tmp/frontend.zip &>>/tmp/expense.log
echo $?

echo -e "\e[32m Enable & restart the nginx \e[0m"
echo $?

systemctl enable nginx  &>>/tmp/expense.log
systemctl restart nginx &>>/tmp/expense.log

echo $?













