source common.sh
log=/tmp/roboshop.log

echo "\e[35m>>>>>>>>>>>>>>> Copy roboshop configuration >>>>>>>>>>>>>>>\e[0m"| tee -a /tmp/roboshop.log
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log}

echo "\e[35m>>>>>>>>>>>>>>> Install Nginx >>>>>>>>>>>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
dnf install nginx -y &>>${log}

echo "\e[35m>>>>>>>>>>>>>>> Clean up Existing content >>>>>>>>>>>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
rm -rf /usr/share/nginx/html/* &>>${log}

echo "\e[35m>>>>>>>>>>>>>>> Download the application content >>>>>>>>>>>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}

echo "\e[35m>>>>>>>>>>>>>>> change the directory >>>>>>>>>>>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
cd /usr/share/nginx/html &>>${log}

echo "\e[35m>>>>>>>>>>>>>>> Extract the content >>>>>>>>>>>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
unzip /tmp/frontend.zip &>>${log}

echo "\e[35m>>>>>>>>>>>>>>> Restart the application >>>>>>>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
systemctl restart nginx &>>${log}
systemctl enable nginx &>>${log}
systemctl status nginx &>>${log}