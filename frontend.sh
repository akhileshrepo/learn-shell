source common.sh

echo "\e[35m>>>>>>>>>>>>>>> Copy roboshop configuration >>>>>>>>>>>>>>>\e[0m"
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

echo "\e[35m>>>>>>>>>>>>>>> Install Nginx >>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
dnf install nginx -y

echo "\e[35m>>>>>>>>>>>>>>> Clean up Existing content >>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
rm -rf /usr/share/nginx/html/*

echo "\e[35m>>>>>>>>>>>>>>> Download the application content >>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo "\e[35m>>>>>>>>>>>>>>> change the directory >>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
cd /usr/share/nginx/html

echo "\e[35m>>>>>>>>>>>>>>> Extract the content >>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
unzip /tmp/frontend.zip

echo "\e[35m>>>>>>>>>>>>>>> Restart the application >>>>>>>>>>>>>>>>>>>>\e[0m"
systemctl restart nginx
systemctl enable nginx
systemctl status nginx