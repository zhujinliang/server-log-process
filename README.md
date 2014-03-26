server-log-process
==================

Process server log of apache and nginx to get statistics.

Cut Nginx and Apache log to files every day.

Get information as you want from access log.


## How to use
Put these code into cron job(crontab -e):


    # cut nginx access log to files
    00 00 * * * /(YOUR_DIR)/cut_nginx_log.sh

    # cut apache access log to files
    00 00 * * * /(YOUR_DIR)/cut_apache_log.sh

    # mobile data statistic
    00 01 * * * /(YOUR_DIR)/count_mobile_data.sh >> /(YOUR_DIR)/mobile_data_statistic.log
