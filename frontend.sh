echo -e "\e[31m installing the nginx \e[0m"

dnf install nginx -y

echo -e "\e[31m copy expense config file \e[0m"

cp expense.conf /etc/nginx/default.d/expense.conf

echo -e "\e[31m removing the file \e[0m"

rm -rf /usr/share/nginx/html/* 

echo -e "\e[31m removing the file \e[0m"

curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip 

echo -e "\e[31m changing the directory \e[0m"

cd /usr/share/nginx/html 

echo -e "\e[31m unzip the file \e[0m"
unzip /tmp/frontend.zip

echo -e "\e[31m Enable & restart the nginx \e[0m"

systemctl enable nginx 
systemctl restart nginx 














