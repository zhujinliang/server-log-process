#!/bin/bash

# NGINX_LOG_PATH="/www/wdlinux/nginx/logs"
NGINX_LOG_PATH="/home/jzhu/projects/server-log-process"


IOS_HEADER="ASIHTTP"
ANDROID_HEADER="Apache-HttpClient"

IGNORE_IP="(221.6.31.164)|(50.116.6.27).*"

ANDROID_APP_NAME="gongpingjia.*.apk"

year=$(date -d "yesterday" +%Y)
month=$(date -d "yesterday" +%m)
day=$(date -d "yesterday" +%d)
year_month_day=$(date -d "yesterday" +%Y%m%d)

date -d "yesterday" +%Y-%m-%d

LOG_FILE=${NGINX_LOG_PATH}/${year}/${month}/${year_month_day}
GPJ_LOG_FILE=${LOG_FILE}_gongpingjia_access.log
MOBILE_LOG_FILE=${LOG_FILE}_mobile_access.log

# 统计二维码扫描次数
log_file=${GPJ_LOG_FILE}
spider_count=$(grep -i "/app/download/.*spider" ${log_file} | cut -d ' ' -f 1 | sort | uniq | wc -l)
all_scan_count=$(grep -i "/app/download" ${log_file} | cut -d ' ' -f 1 | sort | uniq | wc -l)
scan_count=$(( ${all_scan_count} - ${spider_count} ))

echo "二维码扫描次数, ${scan_count}"


# 统计Android APP 下载次数
spider_download_count=$(grep -i "$ANDROID_APP_NAME.*\(spider\|bot\)" ${log_file} | cut -d ' ' -f 1 | sort | uniq | wc -l)
all_download_count=$(grep -i ${ANDROID_APP_NAME} ${log_file} | cut -d ' ' -f 1 | sort | uniq | wc -l)
android_app_download_count=$(( ${all_download_count} - ${spider_download_count} ))

echo "Android APP 下载次数, ${android_app_download_count}"



# 统计iOS和Android端的访问接口次数
# 访问估值接口次数
log_file=${MOBILE_LOG_FILE}
evaluate_flag="evaluate/price-data.*"
android_count=$(grep -c ${evaluate_flag}${ANDROID_HEADER} ${log_file})
ios_count=$(grep -c ${evaluate_flag}${IOS_HEADER} ${log_file})
android_ignore_count=(egrep -c ${IGNORE_IP}${evaluate_flag}${ANDROID_HEADER} ${log_file})
ios_ignore_count=(egrep -c ${IGNORE_IP}${evaluate_flag}${IOS_HEADER} ${log_file})
android_count=$(( ${android_count} - ${android_ignore_count} ))
ios_count=$(( ${ios_count} - ${ios_ignore_count} ))

echo "Android端访问估值接口次数, ${android_count}"
echo "iOS端访问估值接口次数, ${ios_count}"


# 访问买车接口次数
buy_car_flag="buy-car/.*"
android_count=$(grep -c ${buy_car_flag}${ANDROID_HEADER} ${log_file})
ios_count=$(grep -c ${buy_car_flag}${IOS_HEADER} ${log_file})
android_ignore_count=(egrep -c ${IGNORE_IP}${buy_car_flag}${ANDROID_HEADER} ${log_file})
ios_ignore_count=(egrep -c ${IGNORE_IP}${buy_car_flag}${IOS_HEADER} ${log_file})
android_count=$(( ${android_count} - ${android_ignore_count} ))
ios_count=$(( ${ios_count} - ${ios_ignore_count} ))

echo "Android端访问买车接口次数, ${android_count}"
echo "iOS端访问买车接口次数, ${ios_count}"


# 短链接访问次数（即通过短信链接访问的人次数）
log_file=${GPJ_LOG_FILE}
short_url_count=$(egrep 'GET /s/\w{5}' ${log_file} | cut -d ' ' -f 8 | sort | uniq | wc -l)
echo "通过短链接访问的次数, ${short_url_count}"

echo
