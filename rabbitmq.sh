source common.sh

echo -e "\e[36m>>>>>>>>>>>>> Download erlang repos <<<<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>> Download rabbitmq rpm files <<<<<<<<<<<<<<<<<<\e[0m"| tee -a /tmp/roboshop.log
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> Install rabbitmq server <<<<<<<<<<<<<<<<<<<\e[0m"| tee -a /tmp/roboshop.log
dnf install rabbitmq-server -y &>> /tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>>> Restart service <<<<<<<<<<<<<<<<<<<\e[0m"| tee -a /tmp/roboshop.log
systemctl enable rabbitmq-server &>> /tmp/roboshop.log
systemctl restart rabbitmq-server &>>/tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>>>>>>> Adding username and password <<<<<<<<<<<<<<<\e[0m"| tee -a /tmp/roboshop.log
rabbitmqctl add_user roboshop roboshop123 &>> /tmp/roboshop.log

echo -e "\e[36m>>>>>>>>>>>>> Assign permission to user <<<<<<<<<<<<<<<<<<\e[0m"| tee -a /tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> /tmp/roboshop.log
func_exit_status