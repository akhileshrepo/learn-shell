echo -e "\e[36m>>>>>>>> copy Mongo repo file <<<<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log

echo -e "\e[36m>>>>>>>> Install Mongodb <<<<<<<<<<<\e[0m"
dnf install mongodb-org -y /tmp/roboshop.log

echo -e "\e[36m>>>>>>>> Update Listen address <<<<<<<<<<<\e[0m"
#update listen address from 127.0.0.1 to 0.0.0.0
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf /tmp/roboshop.log

echo -e "\e[36m>>>>>>>> Restart the Mongodb <<<<<<<<<<<\e[0m"
systemctl enable mongod /tmp/roboshop.log
systemctl restart mongod /tmp/roboshop.log