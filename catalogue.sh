yum module disable nodejs -y
yum module enable nodejs:18 -y
yum install nodejs -y
cp catalogue.service /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
useradd roboshop
id roboshop
mkdir /app
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
npm install
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
yum install mongodb-org-shell -y
mongo --host mongodb.vinithaws.online </app/schema/catalogue.js

