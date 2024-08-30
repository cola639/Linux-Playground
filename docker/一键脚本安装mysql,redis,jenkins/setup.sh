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
docker-compose -f docker-compose.yml up -d
