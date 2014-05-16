#! /bin/bash

# NGINX_LOG_PATH="/www/wdlinux/nginx/logs"
NGINX_LOG_PATH="/home/jzhu/projects/server-log-process"

NGINX_BACK_LOG_PATH=${NGINX_LOG_PATH}/$(date -d "yesterday" +%Y)/$(date -d "yesterday" +%m)

NGINX_BACK_LOG_NAME_PREFIX=$(date -d "yesterday" +%Y%m%d)_

mkdir -p $NGINX_BACK_LOG_PATH

# Copy old server log
# gongpingjia.com api.gongpingjia.com log
for LOG_FILE in "gongpingjia" "mobile"
do
cp ${NGINX_LOG_PATH}/${LOG_FILE}_access.log ${NGINX_BACK_LOG_PATH}/${NGINX_BACK_LOG_NAME_PREFIX}${LOG_FILE}_access.log
echo 1> ${NGINX_LOG_PATH}/${LOG_FILE}_access.log
done

# Nginx open a new server log file
# service nginxd restart

