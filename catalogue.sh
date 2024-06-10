echo -e "\e[35m>>>>> create catalogue service <<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> Download mongo repos <<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log 

echo -e "\e[35m>>>>> Disable Nodejs module <<<<<<\e[0m" | tee -a /tmp/roboshop.log
dnf module disable nodejs -y &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> Enable Nodejs module <<<<<<\e[0m" | tee -a /tmp/roboshop.log
dnf module enable nodejs:18 -y &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> Install Nodejs <<<<<<\e[0m" | tee -a /tmp/roboshop.log
dnf install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> Adding roboshop user <<<<<<\e[0m" | tee -a /tmp/roboshop.log
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> cleanup the directory <<<<<<\e[0m" | tee -a /tmp/roboshop.log
rm -rf /app &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> change the directory <<<<<<\e[0m" | tee -a /tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> Download the content <<<<<<\e[0m" | tee -a /tmp/roboshop.log
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> change the directory <<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app

echo -e "\e[35m>>>>> Extract the content <<<<<<\e[0m" | tee -a /tmp/roboshop.log
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> change the directory <<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app

echo -e "\e[35m>>>>> Install dependencies <<<<<<\e[0m" | tee -a /tmp/roboshop.log
npm install &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> Install Mongodb <<<<<<\e[0m" | tee -a /tmp/roboshop.log
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> Load schema <<<<<<\e[0m" | tee -a /tmp/roboshop.log
mongo --host mongodb.akhildevops.online </app/schema/catalogue.js &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> Reload the config <<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl daemon-reload &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> Enable the service <<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log

echo -e "\e[35m>>>>> Restart the service <<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log

