#!/bin/bash

APACHE_LOG_PATH="/www/wdlinux/apache/logs"
NGINX_LOG_PATH="/www/wdlinux/nginx/logs"


IOS_HEADER="ASIHTTP"
ANDROID_HEADER="Apache-HttpClient"

ANDROID_APP_NAME="gongpingjia2.0.apk"

year=$(date -d "yesterday" +%Y)
month=$(date -d "yesterday" +%m)
day=$(date -d "yesterday" +%d)
year_month_day=$(date -d "yesterday" +%Y%m%d)

date -d "yesterday" +%Y-%m-%d

# 统计二维码扫描次数
log_file=${APACHE_LOG_PATH}/${year}/${month}/${year_month_day}_access_log
spider_count=$(grep -i "/app/download/.*spider" ${log_file} | cut -d ' ' -f 1 | uniq | wc -l)
all_scan_count=$(grep -i "/app/download" ${log_file} | cut -d ' ' -f 1 | uniq | wc -l)
scan_count=$(( ${all_scan_count} - ${spider_count} ))

echo "二维码扫描次数, ${scan_count}"


# 统计Android APP 下载次数
log_file=${NGINX_LOG_PATH}/${year}/${month}/${year_month_day}_access.log
spider_download_count=$(grep -i "$ANDROID_APP_NAME.*\(spider\|bot\)" ${log_file} | cut -d ' ' -f 1 | uniq | wc -l)
all_download_count=$(grep -i ${ANDROID_APP_NAME} ${log_file} | cut -d ' ' -f 1 | uniq | wc -l)
android_app_download_count=$(( ${all_download_count} - ${spider_download_count} ))

echo "Android APP 下载次数, ${android_app_download_count}"



# 统计iOS和Android端的访问接口次数
# 访问估值接口次数
log_file=${APACHE_LOG_PATH}/${year}mobile/${month}/${year_month_day}_access_log
evaluate_flag="evaluate/price-data.*"
android_count=$(grep -c ${evaluate_flag}${ANDROID_HEADER} ${log_file})
ios_count=$(grep -c ${evaluate_flag}${IOS_HEADER} ${log_file})

echo "Android端访问估值接口次数, ${android_count}"
echo "iOS端访问估值接口次数, ${ios_count}"


# 访问买车接口次数
buy_car_flag="buy-car/.*"
android_count=$(grep -c ${buy_car_flag}${ANDROID_HEADER} ${log_file})
ios_count=$(grep -c ${buy_car_flag}${IOS_HEADER} ${log_file})

echo "Android端访问买车接口次数, ${android_count}"
echo "iOS端访问买车接口次数, ${ios_count}"

echo
