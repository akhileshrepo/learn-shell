cp payment.service /etc/systemd/system/payment.service

dnf install python36 gcc python3-devel -y
useradd roboshop
mkdir /app
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip
cd /app
pip3.6 install -r requirements.txt

systemctl daemon-reload
systemctl enable payment
systemctl restart payment