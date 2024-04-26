# 安装翻墙脚本
bash <(curl -L -s https://raw.githubusercontent.com/wulabing/V2Ray_ws-tls_bash_onekey/master/install.sh) | tee v2ray_ins.log

# ubuntu一键部署warp
创建一个a_script全部文件都放进去
执行1 chmod +x setup.sh
执行2 ./setup.sh

# warp安装 PS 在deb安装包目录打开命令行 注意sudo apt --fix-broken install -y 避免依赖失败问题
sudo dpkg -i cloudflare_warp.deb
apt --fix-broken install
sudo dpkg -i cloudflare_warp.deb
sudo apt update
sudo apt upgrade
warp-cli register
warp-cli --help

# 查看cron定时任务状态 active (running)为正常
systemctl status cron

# cron设置执行时区
sudo timedatectl set-timezone Asia/Shanghai

# 打开定时任务
# 在 nano 编辑器中，您可以按 Ctrl + X，然后按 Y，再按 Enter 来保存。在 vi 或 vim 编辑器中，您可以按 :wq 然后按 Enter 来保存。
sudo crontab -e

# 配置每天6点/19点 关闭warp-cli
0 6 * * * bash /a_script/warp_close.sh
0 19 * * * bash /a_script/warp_close.sh

# 刷新cron定时任务
sudo systemctl restart cron

# 开启warp脚本
bash /a_script/warp_open.sh 

# 关闭warp
bash /a_script/warp_close.sh

# 检查时区
timedatectl

# 选择编辑器
select-editor

# 查看cron定时任务日志
grep CRON /var/log/syslog

# 移除IP
warp-cli remove-excluded-route 112.94.0.0/16
