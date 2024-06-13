source common.sh

echo -e "\e[36m>>>>>>>>>>>>>>> Copy the catalogue service file <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp user.service /etc/systemd/system/user.service &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>> Disable and enable module >>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
dnf module disable nodejs -y &>> /tmp/roboshop.log
dnf module enable nodejs:18 -y &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>> Install Nodejs >>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
dnf install nodejs -y &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>> adding user >>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
useradd roboshop &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>>> Clean up app directory <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
rm -rf /app &>> /tmp/roboshop.log
func_exit_status


echo -e "\e[36m>>>>>>>>>>>>>>> Create app dir <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mkdir /app &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>>> Download app content <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>>> Extract the content <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app &>> /tmp/roboshop.log
unzip /tmp/user.zip &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>>> Download dependencies <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cd /app &>> /tmp/roboshop.log
npm install &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>> Restart the catalogue service <<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl daemon-reload &>> /tmp/roboshop.log
systemctl enable user &>> /tmp/roboshop.log
systemctl restart user &>> /tmp/roboshop.log
func_exit_status


