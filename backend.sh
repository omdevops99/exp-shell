source common.sh

if [ -z "$1" ]; then
  echo password input missing
  exit
fi

MY_ROOT_PASSWORD=$1

echo -e "${color} disable nodejs \e[0m"
dnf module disable nodejs -y  &>>$log_file
status_check


echo -e "${color} enable nodejs \e[0m"
 
dnf module enable nodejs:18 -y  &>>$log_file
status_check

echo -e "${color} install nodejs \e[0m"

dnf install nodejs -y  &>>$log_file
status_check


echo -e "${color} install mysql \e[0m"
dnf install mysql -y  &>>$log_file
status_check

echo -e "${color} create the user and password \e[0m"

mysql -h 172.31.30.179 -uroot -pExpenseApp@1 < /app/schema/backend.sql  &>>$log_file
status_check

echo -e "${color} copy the backend conf file \e[0m"

cp backend.service /etc/systemd/system/backend.service  &>>$log_file
status_check

echo -e "${color} Adding the user \e[0m"
id expense &>>$log_file
if [ $? -ne 0 ]; then

 useradd expense  &>>$log_file
 status_check

fi

if [ ! -d /app ]; then
   echo -e "${color} creating the application directory \e[0m"
   mkdir /app  &>>$log_file
   status_check   
fi

echo -e "${color} Delete old Application Content \e[0m"
rm -rf /app/* &>>$log_file
status_check


echo -e "${color} Download application content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip  &>>$log_file
status_check

echo -e "${color} Extract the application content \e[0m"
cd /app &>>$log_file
unzip /tmp/backend.zip &>>$log_file
status_check

echo -e "${color} changing the directory and install the dependency \e[0m"

npm install &>>$log_file
status_check

echo -e "${color} starting the backend services \e[0m"
systemctl daemon-reload &>>$log_file  
systemctl enable backend &>>log_file
systemctl start backend &>>log_file

status_check

