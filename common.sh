log=/tmp/roboshop.log

func_exit_status() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32m>>>> SUCCESS <<<<<\e[0m"
  else
    echo -e "\e[31m>>>> FAILURE <<<<<<\e[0m"
  fi
}

func_apppreq() {
  echo -e "\e[36m>>>>>>>>>>>>> Copy ${component} configuration <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
  cp ${component}.service /etc/systemd/system/${component}.service &>> /tmp/roboshop.log
  func_exit_status

  echo -e "\e[36m>>>>>>>>>>>> Adding user >>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
  id roboshop &>> /tmp/roboshop.log
  if [ $? -ne 0 ]; then
    useradd roboshop
  fi
  func_exit_status

  echo -e "\e[36m>>>>>>>>>>>>>>> Clean up app directory <<<<<<<<<<<<<<<\e[0m"
  rm -rf /app
  func_exit_status


  echo -e "\e[36m>>>>>>>>>>>>>>> Create app dir <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
  mkdir /app &>> /tmp/roboshop.log
  func_exit_status

  echo -e "\e[36m>>>>>>>>>>>>>> Download app content >>>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> /tmp/roboshop.log
  func_exit_status

  echo -e "\e[36m>>>>>>>>>>>>>>> Extract the content <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
  cd /app &>> /tmp/roboshop.log
  unzip /tmp/${component}.zip &>> /tmp/roboshop.log
  func_exit_status
}

func_schema_setup() {
  if [ "${schema_type}" == "mongodb" ]; then
    echo -e "\e[36m>>>>>>>>>>>>  Install Mongo Client  <<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
    yum install mongodb-org-shell -y &>>${log}
    func_exit_status

    echo -e "\e[36m>>>>>>>>>>>>  Load User Schema  <<<<<<<<<<<<\e[0m"  | tee -a /tmp/roboshop.log
    mongo --host 172.31.31.224 </app/schema/${component}.js &>>${log}
    func_exit_status
  fi

  if [ "${schema_type}" == "mysql" ]; then
      echo -e "\e[36m>>>>>>>>>>>>  Install MySQL Client   <<<<<<<<<<<<\e[0m"
      yum install mysql -y &>>${log}
      func_exit_status

      echo -e "\e[36m>>>>>>>>>>>>  Load Schema   <<<<<<<<<<<<\e[0m"
      mysql -h 172.31.34.73 -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log}
      func_exit_status
  fi
}

func_systemd() {
  echo -e "\e[36m>>>>>>>>>>>>>>>> Restart the ${component} service <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
  systemctl daemon-reload &>> /tmp/roboshop.log
  systemctl enable ${component} &>> /tmp/roboshop.log
  systemctl restart ${component} &>> /tmp/roboshop.log
  func_exit_status
}


func_nodejs() {
  echo -e "\e[36m>>>>>>>>>>>>>>>>Download mongo repo file <<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop.log
  func_exit_status

  func_apppreq

  echo -e "\e[36m>>>>>>>>>>>> Disable and enable module >>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
  dnf module disable nodejs -y &>> /tmp/roboshop.log
  dnf module enable nodejs:18 -y &>> /tmp/roboshop.log
  func_exit_status

  echo -e "\e[36m>>>>>>>>>>>>>> Install Nodejs >>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
  dnf install nodejs -y &>> /tmp/roboshop.log
  func_exit_status

  echo -e "\e[36m>>>>>>>>>>>>> Install Dependencies <<<<<<<<<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
  cd /app &>> /tmp/roboshop.log
  npm install &>> /tmp/roboshop.log
  func_exit_status

  func_schema_setup

  func_systemd
}

func_java() {

   echo -e "\e[36m>>>>>>>>>>>>>> Build Maven  >>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
   dnf install maven -y &>> /tmp/roboshop.log
   func_exit_status

   func_apppreq

   echo -e "\e[36m>>>>>>>>>>>>> Download dependencies <<<<<<<<<<<<<<\e[0m" | tee -a /tmp/roboshop.log
   mvn clean package &>> /tmp/roboshop.log
   mv target/shipping-1.0.jar shipping.jar &>> /tmp/roboshop.log
   func_exit_status

   func_schema_setup

   func_systemd
}

func_python() {
  echo -e "\e[36m>>>>>>>>>>> Install python packages <<<<<<<<<<<<<<<" | tee -a /tmp/roboshop.log
  dnf install python36 gcc python3-devel -y &>> /tmp/roboshop.log
  func_exit_status

  func_apppreq

  echo -e "\e[36m>>>>>>>>>>> Install pip packages <<<<<<<<<<<<<<" | tee -a /tmp/roboshop.log
  pip3.6 install -r requirements.txt &>> /tmp/roboshop.log
  func_exit_status

  func_systemd
}
