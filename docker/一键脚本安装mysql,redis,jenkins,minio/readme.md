# 一键部署 mysql redis jenkins

# 文件夹放到同一目录 注意 Vscode LF 格式写 sh 脚本

# 赋予权限 当前目录执行 setup.sh

chmod +x setup.sh
./setup.sh

FAQ

# 彻底删除 jenkins

sudo rm -rf /var/lib/jenkins # 如果你使用的是默认的 Jenkins 数据目录
sudo rm -rf /home/jenkins # 如果你在 docker-compose.yml 中指定了该路径

# 彻底删除容器

docker stop $(docker ps -aq) # 停止全部容器
docker rm $(docker ps -aq) # 删除全部容器
docker rmi $(docker images -aq) # 删除全部镜像
