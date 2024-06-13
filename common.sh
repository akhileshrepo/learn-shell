log=/tmp/roboshop.log

func_exit_status() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32m>>>> SUCCESS <<<<<\e[0m"
  else
    echo -e "\e[31m>>>> FAILURE <<<<<<\e[0m"
  fi
}

