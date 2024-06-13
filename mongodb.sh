source common.sh

echo -e "\e[36m>>>>>>>> copy Mongo repo file <<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>> Install Mongodb <<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
dnf install mongodb-org -y &>>/tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>> Update Listen address <<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
#update listen address from 127.0.0.1 to 0.0.0.0
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>/tmp/roboshop.log
func_exit_status

echo -e "\e[36m>>>>>>>> Restart the Mongodb <<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
systemctl enable mongod  &>>/tmp/roboshop.log
systemctl restart mongod  &>>/tmp/roboshop.log
func_exit_status