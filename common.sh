log=/tmp/roboshop.log

func_exit_status() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32m>>>> SUCCESS <<<<<\e[0m"
  else
    echo -e "\e[31m>>>> FAILURE <<<<<<\e[0m"
  fi
}

func_apppreq() {
  echo -e "\e[36m>>>>>>>>>>>> Adding user >>>>>>>>>>>>>>>\e[0m" | tee -a /tmp/roboshop.log
  id roboshop &>> /tmp/roboshop.log
  if [ $? -ne 0 ]; then
    useradd roboshop
  fi
  func_exit_status

  echo -e "\e[36m>>>>>>>>>>>>>>> Clean up app directory <<<<<<<<<<<<<<<\e[0m"
  rm -rf /app
  func_exit_status
}

