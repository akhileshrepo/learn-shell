rabbitmq_app_password=$1
if [ -z "${rabbitmq_app_password}" ]; then
  echo "Input Rabbitmq app password missing"
  exit 1
fi

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
dnf install rabbitmq-server -y

rabbitmqctl add_user roboshop ${rabbitmq_app_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

systemctl enable rabbitmq-server
systemctl restart rabbitmq-server