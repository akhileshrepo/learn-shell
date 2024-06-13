source common.sh

echo -e "\e[36m>>>>>>>>>>>>> Copy catalogue configuration <<<<<<<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>> Disable and Enable Nodejs module >>>>>>>>>>>\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> Install Nodejs >>>>>>>>>>>>>>>\e[0m"
dnf install nodejs -y
func_exit_status

echo -e "\e[36m>>>>>>>>>>>> Adding user >>>>>>>>>>>>>>>\e[0m"
useradd roboshop
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>>> Create app directory >>>>>>>>>>>>>>\e[0m"
mkdir /app
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> Download app content >>>>>>>>>>>>>>>>\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> Extract the content <<<<<<<<<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip
func_exit_status

echo _e "\e[36m>>>>>>>>>>>>> Install Dependencies <<<<<<<<<<<<<<<<<<<<<\e[0m"
cd /app
npm install
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>Restart the service <<<<<<<<<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>>>>Download mongo repo file <<<<<<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>>>>>>>>>>Install Mongodb client<<<<<<<<<<<<<<<<<<\e[0m"
dnf install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>>>>>>>> Load schema<<<<<<<<<<<<<<<<<<<<<<<<\e[0m"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js

