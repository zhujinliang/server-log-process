#! /bin/bash

year=$(date -d "yesterday" +%Y)
month=$(date -d "yesterday" +%m)
day=$(date -d "yesterday" +%d)
year_month_day=$(date -d "yesterday" +%Y%m%d)

# 网站访问日志分割 
APACHE_LOG_PATH="/www/wdlinux/apache/logs"

APACHE_BACK_LOG_PATH=${APACHE_LOG_PATH}/${year}/${month}

APACHE_BACK_LOG_NAME=${year_month_day}_access_log
mkdir -p $APACHE_BACK_LOG_PATH

# 复制老的日志文件
cp ${APACHE_LOG_PATH}/access_log ${APACHE_BACK_LOG_PATH}/${APACHE_BACK_LOG_NAME}
echo 1> ${APACHE_LOG_PATH}/access_log

# apache重新开一个新的日志
# service httpd restart


# Mobile接口调用日志分割
MOBILE_APACHE_BACK_LOG_PATH=${APACHE_LOG_PATH}/${year}mobile/${month}

mkdir -p $MOBILE_APACHE_BACK_LOG_PATH

cp ${APACHE_LOG_PATH}/mobile_access_log ${MOBILE_APACHE_BACK_LOG_PATH}/${APACHE_BACK_LOG_NAME}
echo 1> ${APACHE_LOG_PATH}/mobile_access_log
