#!/bin/bash

NGINX_LOG_PATH="/www/wdlinux/nginx/logs"


MM_LOG_FILE=${NGINX_LOG_PATH}/mm_access.log

echo "============================"
# echo yesterday date
date -d "yesterday" +%Y-%m-%d

for flag in "a" "b" "c" "d" "e" "f" "g" "h"
do
	cmd='/'${flag}'/ .* mobile'
	count=$(egrep -i "${cmd}" ${MM_LOG_FILE} | cut -d ' ' -f2 | sort | uniq -c | wc -l)
	echo "Team " ${flag} "扫码访问数量: " ${count} 
done

echo
