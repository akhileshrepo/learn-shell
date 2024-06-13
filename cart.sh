

dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
mkdir /app
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip
cd /app
npm install
