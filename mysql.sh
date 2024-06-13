source common.sh

echo -e "\e[36m>>>>>>>>>>>>>>>>>>>>>> Disable mysql module <<<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
dnf module disable mysql -y &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>>>>> Download the repo files <<<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp mysql.repo /etc/yum.repos.d/mysql.repo &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>>>> Install mysql <<<<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
dnf install mysql-community-server -y &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>>>> Restart the service <<<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl enable mysqld &>> /tmp/roboshop.log
systemctl start mysqld &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>>> Set Root Password for mysql <<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
mysql_secure_installation --set-root-pass RoboShop@1 &>> /tmp/roboshop.log
func_exit_status