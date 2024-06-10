source common.sh

echo -e "\e[35m>>>>> Install Nginx <<<<<<\e[0m" | tee -a ${log}
dnf install nginx -y &>>/tmp/roboshop.log
func_exit_status

echo -e "\e[35m>>>>> Copy Roboshop configuration<<<<<<\e[0m" | tee -a ${log}
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log
func_exit_status

echo -e "\e[35m>>>>> Remove the Existing content <<<<<<\e[0m" | tee -a ${log}
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log
func_exit_status

echo -e "\e[35m>>>>> Download app content <<<<<<\e[0m" | tee -a ${log}
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log
func_exit_status

echo -e "\e[35m>>>>> Change the directory <<<<<<\e[0m" | tee -a ${log}
cd /usr/share/nginx/html &>>/tmp/roboshop.log
func_exit_status

echo -e "\e[35m>>>>> Unzip the app content <<<<<<\e[0m" | tee -a ${log}
unzip /tmp/frontend.zip &>>/tmp/roboshop.log
func_exit_status

echo -e "\e[35m>>>>> Reload and restart the service <<<<<<\e[0m" | tee -a ${log}
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log
func_exit_status