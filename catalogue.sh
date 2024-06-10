echo -e "\e[35m>>>>> create catalogue service <<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[35m>>>>> Download mongo repos <<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[35m>>>>> Disable Nodejs module <<<<<<\e[0m"
dnf module disable nodejs -y

echo -e "\e[35m>>>>> Enable Nodejs module <<<<<<\e[0m"
dnf module enable nodejs:18 -y

echo -e "\e[35m>>>>> Install Nodejs <<<<<<\e[0m"
dnf install nodejs -y

echo -e "\e[35m>>>>> Adding roboshop user <<<<<<\e[0m"
useradd roboshop

echo -e "\e[35m>>>>> change the directory <<<<<<\e[0m"
mkdir /app

echo -e "\e[35m>>>>> Download the content <<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[35m>>>>> change the directory <<<<<<\e[0m"
cd /app

echo -e "\e[35m>>>>> Extract the content <<<<<<\e[0m"
unzip /tmp/catalogue.zip

echo -e "\e[35m>>>>> change the directory <<<<<<\e[0m"
cd /app

echo -e "\e[35m>>>>> Install dependencies <<<<<<\e[0m"
npm install

echo -e "\e[35m>>>>> Install Mongodb <<<<<<\e[0m"
dnf install mongodb-org-shell -y

echo -e "\e[35m>>>>> Load schema <<<<<<\e[0m"
mongo --host mongodb.akhildevops.online </app/schema/catalogue.js

echo -e "\e[35m>>>>> Reload the config <<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[35m>>>>> Enable the service <<<<<<\e[0m"
systemctl enable catalogue

echo -e "\e[35m>>>>> Restart the service <<<<<<\e[0m"
systemctl restart catalogue

