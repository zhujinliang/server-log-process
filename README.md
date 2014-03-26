server-log-process
==================

Process server log of apache and nginx to get statistics.


## How to use
Put these code into cron job(cron -e):


    # cut nginx access log to files
    00 00 * * * /(YOUR_DIR)/cut_nginx_log.sh

    # cut apache access log to files
    00 00 * * * /(YOUR_DIR)/cut_apache_log.sh

    # mobile data statistic
    00 01 * * * /(YOUR_DIR)/count_mobile_data.sh >> /(YOUR_DIR)/mobile_data_statistic.log
