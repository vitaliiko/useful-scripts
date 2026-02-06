#!/usr/bin/env bash

# This script could be called inside Docker container 
# to set up cron job that will be calling some script 
# that is placed in a core directory


cron_dir=/etc/cron.d
cron_file=$cron_dir/cron-job
log_file=/var/log/cron.log

mkdir -p $cron_dir
touch $cron_file
echo "$CRON_EXPRESSION /job.sh >> $log_file 2>&1" > $cron_file
echo >> $cron_file

chmod 0644 $cron_file
crontab $cron_file
touch $log_file
/usr/sbin/crond
