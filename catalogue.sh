source common.sh

echo -e "\e[36m>>>>>>>>>>>>> Copy catalogue configuration <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp catalogue.service /etc/systemd/system/catalogue.service &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>>>>Download mongo repo file <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>>>> Disable and Enable Nodejs module >>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
dnf module disable nodejs -y &>> /tmp/roboshop.log
dnf module enable nodejs:18 -y &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> Install Nodejs >>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
dnf install nodejs -y &>> /tmp/roboshop.log
func_exit_status

func_apppreq


echo -e "\e[36m>>>>>>>>>>>>>>> Create app directory >>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
mkdir /app &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> Download app content >>>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> Extract the content <<<<<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app &>> /tmp/roboshop.log
unzip /tmp/catalogue.zip &>> /tmp/roboshop.log
func_exit_status

echo _e "\e[36m>>>>>>>>>>>>> Install Dependencies <<<<<<<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app &>> /tmp/roboshop.log
npm install &>> /tmp/roboshop.log
func_exit_status


echo -e "\e[36m>>>>>>>>>>>>>>>>Install Mongodb client<<<<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
dnf install mongodb-org-shell -y &>> /tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>>>>> Load schema<<<<<<<<<<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mongo --host 172.31.28.147 </app/schema/catalogue.js &>> /tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>>>Restart the service <<<<<<<<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable catalogue &>> /tmp/roboshop.log
systemctl restart catalogue &>> /tmp/roboshop.log
func_exit_status
