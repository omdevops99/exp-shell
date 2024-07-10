log_file=/tmp/expense/log
color="\e[33m"


echo -e "${color} disable nodejs \e[0m"
dnf module disable nodejs -y  &>>$log_file

echo $?

echo -e "${color} disable nodejs \e[0m"
 enable nodejs \e[0m"
dnf module enable nodejs:18 -y  &>>$log_file

echo $?
echo -e "${color} install nodejs \e[0m"

dnf install nodejs -y  &>>$log_file
echo $?

echo -e "${color} install mysql \e[0m"
dnf install mysql -y  &>>$log_file
echo $?

echo -e "${color} create the user and password \e[0m"

mysql -h 172.31.30.179 -uroot -pExpenseApp@1 < /app/schema/backend.sql  &>>$log_file
echo $?

echo -e "${color} copy the backend conf file \e[0m"

cp backend.service /etc/systemd/system/backend.service  &>>$log_file
echo $?

echo -e "${color} Adding the user \e[0m"
useradd expense  &>>$log_file

echo $?

echo -e "${color} creating the directory \e[0m"

mkdir /app  &>>$log_file

echo $?

echo -e "${color} extracting the url \e[0m"


curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip  &>>$log_file
echo $?

echo -e "${color}changing the directory & Unzip the file \e[0m"

cd /app &>>$log_file

echo $?

unzip /tmp/backend.zip &>>log_file
echo $?


echo -e "${color} changing the directory and install the dependency \e[0m"

npm install &>>$log_file
echo $?

echo -e "${color} starting the backend services \e[0m"
systemctl deamon-reload  &>>$log_file
echo $?

systemctl enable backend &>>log_file
echo $?

systemctl start backend &>>log_file
echo $?
