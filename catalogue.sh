log=/tmp/roboshop.log

echo -e "\e[35m>>>>> create catalogue service <<<<<<\e[0m" | tee -a ${log}
cp catalogue.service /etc/systemd/system/catalogue.service &>>${log}

echo -e "\e[35m>>>>> Download mongo repos <<<<<<\e[0m" | tee -a ${log}
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log} 

echo -e "\e[35m>>>>> Disable Nodejs module <<<<<<\e[0m" | tee -a ${log}
dnf module disable nodejs -y &>>${log}

echo -e "\e[35m>>>>> Enable Nodejs module <<<<<<\e[0m" | tee -a ${log}
dnf module enable nodejs:18 -y &>>${log}

echo -e "\e[35m>>>>> Install Nodejs <<<<<<\e[0m" | tee -a ${log}
dnf install nodejs -y &>>${log}

echo -e "\e[35m>>>>> Adding roboshop user <<<<<<\e[0m" | tee -a ${log}
useradd roboshop &>>${log}

echo -e "\e[35m>>>>> cleanup the directory <<<<<<\e[0m" | tee -a ${log}
rm -rf /app &>>${log}

echo -e "\e[35m>>>>> change the directory <<<<<<\e[0m" | tee -a ${log}
mkdir /app &>>${log}

echo -e "\e[35m>>>>> Download the content <<<<<<\e[0m" | tee -a ${log}
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}

echo -e "\e[35m>>>>> change the directory <<<<<<\e[0m" | tee -a ${log}
cd /app

echo -e "\e[35m>>>>> Extract the content <<<<<<\e[0m" | tee -a ${log}
unzip /tmp/catalogue.zip &>>${log}

echo -e "\e[35m>>>>> change the directory <<<<<<\e[0m" | tee -a ${log}
cd /app

echo -e "\e[35m>>>>> Install dependencies <<<<<<\e[0m" | tee -a ${log}
npm install &>>${log}

echo -e "\e[35m>>>>> Install Mongodb <<<<<<\e[0m" | tee -a ${log}
dnf install mongodb-org-shell -y &>>${log}

echo -e "\e[35m>>>>> Load schema <<<<<<\e[0m" | tee -a ${log}
mongo --host mongodb.akhildevops.online </app/schema/catalogue.js &>>${log}

echo -e "\e[35m>>>>> Reload the config <<<<<<\e[0m" | tee -a ${log}
systemctl daemon-reload &>>${log}

echo -e "\e[35m>>>>> Enable the service <<<<<<\e[0m" | tee -a ${log}
systemctl enable catalogue &>>${log}

echo -e "\e[35m>>>>> Restart the service <<<<<<\e[0m" | tee -a ${log}
systemctl restart catalogue &>>${log}
