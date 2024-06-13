source common.sh


echo -e "\e[36m>>>>>>>>>>>> Download redis repos <<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> enable redis module <<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
dnf module enable redis:remi-6.2 -y &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> Install redis <<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
dnf install redis -y &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> update listen address <<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>> /tmp/roboshop.log
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> Restart the service <<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl enable redis &>> /tmp/roboshop.log
systemctl restart redis &>> /tmp/roboshop.log
func_exit_status
