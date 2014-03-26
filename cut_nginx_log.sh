#! /bin/bash

NGINX_LOG_PATH="/www/wdlinux/nginx/logs"

NGINX_BACK_LOG_PATH=${NGINX_LOG_PATH}/$(date -d "yesterday" +%Y)/$(date -d "yesterday" +%m)

NGINX_BACK_LOG_NAME=$(date -d "yesterday" +%Y%m%d)_access.log
mkdir -p $NGINX_BACK_LOG_PATH

# 复制老的日志文件
cp ${NGINX_LOG_PATH}/access.log ${NGINX_BACK_LOG_PATH}/${NGINX_BACK_LOG_NAME}
echo 1> ${NGINX_LOG_PATH}/access.log

# nginx重新开一个新的日志
# service nginxd restart

