#!/bin/bash

# 获取当前连接到本机的 IP 地址
ip_addr=$(who am i | awk '{print $NF}' | tr -d '()')

# 打印ip_addr
echo $ip_addr

# 添加排除路由
warp-cli add-excluded-route $ip_addr

# 查看当前排除路由列表
warp-cli excluded-routes

# 连接
warp-cli connect
