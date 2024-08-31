#!/bin/bash

# 检查 Docker 是否已安装
if ! command -v docker &>/dev/null; then
  echo "Docker 未安装，正在安装 Docker..."
  sudo apt-get update &&
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common &&
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
    sudo apt-get update &&
    sudo apt-get install -y docker-ce &&
    docker --version
else
  echo "Docker 已安装，跳过 Docker 安装步骤。"
fi

# 检查 Docker Compose 是否已安装
if ! command -v docker-compose &>/dev/null; then
  echo "Docker Compose 未安装，正在安装 Docker Compose..."
  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&
    sudo chmod +x /usr/local/bin/docker-compose &&
    docker-compose --version
else
  echo "Docker Compose 已安装，跳过 Docker Compose 安装步骤。"
fi

# 运行 docker-compose.yml
echo "安装 mysql redis jenkins 配置..."
# 使用 docker-compose 启动服务
docker-compose -f docker-compose.yml up -d

# 检查上一个命令是否成功
if [ $? -eq 0 ]; then
  echo "安装 mysql, redis, jenkins 配置完成！"

  # 输出 Jenkins 的初始管理员密码
  if [ -f /home/jenkins-compose/secrets/initialAdminPassword ]; then
    echo "Jenkins 初始管理员密码如下："
    cat /var/jenkins_home/secrets/initialAdminPassword
  else
    echo "无法找到 Jenkins 初始管理员密码文件，请检查 Jenkins 容器是否正确启动。"
  fi
else
  echo "安装过程中出现错误，请检查日志。"
fi
