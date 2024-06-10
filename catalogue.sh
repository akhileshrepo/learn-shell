echo ">>>>>> create catalogue service <<<<<<"
cp catalogue.service /etc/systemd/system/catalogue.service

echo ">>>>>> Download mongo repos <<<<<<"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo ">>>>>> Disable Nodejs module <<<<<<"
dnf module disable nodejs -y

echo ">>>>>> Enable Nodejs module <<<<<<"
dnf module enable nodejs:18 -y

echo ">>>>>> Install Nodejs <<<<<<"
dnf install nodejs -y

echo ">>>>>> Adding roboshop user <<<<<<"
useradd roboshop

echo ">>>>>> change the directory <<<<<<"
mkdir /app

echo ">>>>>> Download the content <<<<<<"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo ">>>>>> change the directory <<<<<<"
cd /app

echo ">>>>>> Extract the content <<<<<<"
unzip /tmp/catalogue.zip

echo ">>>>>> change the directory <<<<<<"
cd /app

echo ">>>>>> Install dependencies <<<<<<"
npm install

echo ">>>>>> Install Mongodb <<<<<<"
dnf install mongodb-org-shell -y

echo ">>>>>> Load schema <<<<<<"
mongo --host mongodb.akhildevops.online </app/schema/catalogue.js

echo ">>>>>> Reload the config <<<<<<"
systemctl daemon-reload

echo ">>>>>> Enable the service <<<<<<"
systemctl enable catalogue

echo ">>>>>> Restart the service <<<<<<"
systemctl restart catalogue

